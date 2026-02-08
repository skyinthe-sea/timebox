import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/analytics/data/datasources/analytics_local_datasource.dart';
import '../../features/analytics/data/models/period_cache_model.dart';
import '../../features/analytics/data/repositories/analytics_repository_impl.dart';
import '../../features/analytics/presentation/bloc/statistics_state.dart';

/// Write-Through 통계 캐시 서비스
///
/// CRUD 시점에 즉시 통계를 재계산하여 항상 따뜻한 캐시를 유지합니다.
/// - 300ms 디바운스로 연속 CRUD 시 한 번만 재계산
/// - 날짜별 독립 타이머로 서로 영향 없음
/// - fire-and-forget 방식으로 CRUD 경로를 블로킹하지 않음
class StatsUpdateService {
  final AnalyticsRepositoryImpl _analyticsRepository;
  final AnalyticsLocalDataSource _analyticsDataSource;

  /// 날짜별 디바운스 타이머
  final Map<String, Timer> _debounceTimers = {};

  /// 동시 실행 방지 락
  final Set<String> _activeLocks = {};

  /// 재계산 진행 중 새 변경이 발생한 날짜 (재실행 필요)
  final Set<String> _pendingRerun = {};

  /// 리포트 페이지 활성 여부
  bool _isReportActive = false;

  /// 재계산 보류된 날짜들 (period cache rebuild 스킵됨)
  final Set<String> _dirtyDates = {};

  /// 통계 업데이트 완료 알림 스트림
  final _controller = StreamController<DateTime>.broadcast();

  Stream<DateTime> get onStatsUpdated => _controller.stream;

  StatsUpdateService({
    required AnalyticsRepositoryImpl analyticsRepository,
    required AnalyticsLocalDataSource analyticsDataSource,
  })  : _analyticsRepository = analyticsRepository,
        _analyticsDataSource = analyticsDataSource;

  /// 특정 날짜의 일간 통계 강제 재계산 (UI 새로고침용)
  ///
  /// 디바운스 없이 즉시 재계산하여 Hive 캐시를 업데이트합니다.
  /// period cache 리빌드는 하지 않습니다.
  Future<void> forceRecalculateDaily(DateTime date) async {
    try {
      await _analyticsRepository.saveDailyStatsSummary(date);
      debugPrint('[StatsUpdateService] Force recalculated daily stats for: ${_dateKey(date)}');
    } catch (e) {
      debugPrint('[StatsUpdateService] Error force recalculating: $e');
    }
  }

  /// CRUD 후 호출 (fire-and-forget, 논블로킹)
  ///
  /// 300ms 디바운스 후 백그라운드에서 해당 날짜의 통계를 재계산합니다.
  void onDataChanged(DateTime date) {
    final key = _dateKey(date);
    _debounceTimers[key]?.cancel();
    _debounceTimers[key] = Timer(const Duration(milliseconds: 300), () {
      _recalculateForDate(date);
    });
  }

  /// 리포트 페이지 활성/비활성 전환
  ///
  /// 활성화 시 보류된 dirty dates를 flush하여 period cache를 무효화합니다.
  /// Future를 반환하여 호출자가 flush 완료를 기다릴 수 있습니다.
  Future<void> setReportPageActive(bool active) async {
    _isReportActive = active;
    if (active && _dirtyDates.isNotEmpty) {
      await _flushDirtyDates();
    }
  }

  /// 보류된 dirty dates의 period cache를 무효화하고 알림
  Future<void> _flushDirtyDates() async {
    final dates = Set<String>.from(_dirtyDates);
    _dirtyDates.clear();

    // 영향받는 주간/월간 캐시 키 수집 (중복 제거)
    final cacheKeysToInvalidate = <String>{};
    for (final key in dates) {
      final date = DateTime.parse(key);
      cacheKeysToInvalidate.add(PeriodCacheModel.weeklyKey(date));
      cacheKeysToInvalidate.add(PeriodCacheModel.monthlyKey(date));
    }

    // Hive period cache 삭제
    for (final cacheKey in cacheKeysToInvalidate) {
      await _analyticsDataSource.deletePeriodCache(cacheKey);
    }

    debugPrint('[StatsUpdateService] Flushed ${dates.length} dirty dates, '
        'invalidated ${cacheKeysToInvalidate.length} period caches');

    // StatisticsBloc에 변경 알림 → 메모리 캐시 클리어 유도
    if (!_controller.isClosed) {
      _controller.add(DateTime.now());
    }
  }

  /// 앱 시작 시 오늘 통계 보장
  Future<void> ensureTodayStats() async {
    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);
    try {
      // 이월 알고리즘 v2 마이그레이션: 최근 30일 캐시 리프레시 (1회성)
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getBool('rollover_v2_migrated') != true) {
        debugPrint('[StatsUpdateService] Migrating rollover v2: recalculating last 30 days');
        await recalculateRange(
          normalizedToday.subtract(const Duration(days: 30)),
          normalizedToday,
        );
        await prefs.setBool('rollover_v2_migrated', true);
        debugPrint('[StatsUpdateService] Rollover v2 migration complete');
        return; // recalculateRange already covers today
      }

      final cached =
          await _analyticsDataSource.getDailyStatsSummary(normalizedToday);
      if (cached == null) {
        await _recalculateForDate(normalizedToday);
      }
    } catch (e) {
      debugPrint('[StatsUpdateService] ensureTodayStats error: $e');
    }
  }

  /// 핵심: 일간 통계 재계산 + 기간 캐시 리빌드
  Future<void> _recalculateForDate(DateTime date) async {
    final key = _dateKey(date);

    // 이미 실행 중이면 재실행 예약 후 리턴
    if (_activeLocks.contains(key)) {
      _pendingRerun.add(key);
      debugPrint('[StatsUpdateService] Recalculation in progress for $key, scheduled re-run');
      return;
    }
    _activeLocks.add(key);

    try {
      debugPrint('[StatsUpdateService] Recalculating stats for: $key');

      // 1. 일간 통계는 항상 재계산 (가벼움, ~6 Hive reads)
      await _analyticsRepository.saveDailyStatsSummary(date);

      if (_isReportActive) {
        // 2a. 리포트 보는 중: 기존 full rebuild
        await _rebuildPeriodCaches(date);
      } else {
        // 2b. 리포트 안 보는 중: dirty만 마킹 (period cache 재빌드 스킵!)
        _dirtyDates.add(key);
        debugPrint('[StatsUpdateService] Deferred period cache rebuild for: $key');
      }

      // 항상 BLoC에 통지 (StatefulShellRoute에서 initState 재실행 안 됨)
      if (!_controller.isClosed) {
        _controller.add(date);
      }

      debugPrint('[StatsUpdateService] Stats updated for: $key');
    } catch (e) {
      debugPrint('[StatsUpdateService] Error recalculating stats for $key: $e');
    } finally {
      _activeLocks.remove(key);

      // 진행 중 새 변경이 있었으면 재실행
      if (_pendingRerun.remove(key)) {
        debugPrint('[StatsUpdateService] Re-running recalculation for: $key');
        _recalculateForDate(date);
      }
    }
  }

  /// 주간/월간 PeriodCache 리빌드
  Future<void> _rebuildPeriodCaches(DateTime date) async {
    try {
      final normalizedDate = DateTime(date.year, date.month, date.day);

      // 주간 범위 계산
      final weekStart =
          normalizedDate.subtract(Duration(days: normalizedDate.weekday - 1));
      final weekEnd = weekStart.add(const Duration(days: 6));

      // 월간 범위 계산
      final monthStart = DateTime(normalizedDate.year, normalizedDate.month, 1);
      final monthEnd =
          DateTime(normalizedDate.year, normalizedDate.month + 1, 0);

      // 주간/월간 캐시 병렬 리빌드
      await Future.wait([
        _rebuildSinglePeriodCache(
          cacheKey: PeriodCacheModel.weeklyKey(normalizedDate),
          start: weekStart,
          end: weekEnd,
        ),
        _rebuildSinglePeriodCache(
          cacheKey: PeriodCacheModel.monthlyKey(normalizedDate),
          start: monthStart,
          end: monthEnd,
        ),
      ]);
    } catch (e) {
      debugPrint('[StatsUpdateService] Error rebuilding period caches: $e');
    }
  }

  /// 단일 기간 캐시 리빌드
  Future<void> _rebuildSinglePeriodCache({
    required String cacheKey,
    required DateTime start,
    required DateTime end,
  }) async {
    try {
      final today = DateTime.now();

      // 6개 쿼리 병렬 실행 (_loadPeriodData와 동일)
      final results = await Future.wait([
        _loadPeriodStats(start, end, today),
        _analyticsRepository.getTagStatistics(start, end),
        _analyticsRepository.getTaskPipelineStats(start, end),
        _analyticsRepository.getTimeComparisons(start, end),
        _analyticsRepository.getTaskCompletionRankings(start, end),
        _analyticsRepository.getDailyStatsSummaries(start, end),
      ]);

      final periodStats = results[0] as dynamic;
      final tagStats = (results[1] as dynamic).fold(
        (failure) => [],
        (stats) => stats,
      );
      final pipelineStats = (results[2] as dynamic).fold(
        (failure) => null,
        (stats) => stats,
      );
      final timeComparisons = (results[3] as dynamic).fold(
        (failure) => [],
        (comparisons) => comparisons,
      );
      final rankingsResult = results[4];
      final topSuccessTasks = (rankingsResult as dynamic).fold(
        (failure) => [],
        (rankings) => rankings.topSuccess,
      );
      final topFailureTasks = (rankingsResult as dynamic).fold(
        (failure) => [],
        (rankings) => rankings.topFailure,
      );
      final periodSummaries = (results[5] as dynamic).fold(
        (failure) => [],
        (summaries) => summaries,
      );

      final cache = PeriodCache(
        periodStats: List.from(periodStats),
        tagStats: List.from(tagStats),
        pipelineStats: pipelineStats,
        periodSummaries: List.from(periodSummaries),
        timeComparisons: List.from(timeComparisons),
        topSuccessTasks: List.from(topSuccessTasks),
        topFailureTasks: List.from(topFailureTasks),
      );

      final cacheModel = PeriodCacheModel.fromEntity(
        cacheKey: cacheKey,
        cache: cache,
      );
      await _analyticsDataSource.savePeriodCache(cacheModel);

      debugPrint('[StatsUpdateService] Period cache rebuilt: $cacheKey');
    } catch (e) {
      debugPrint(
          '[StatsUpdateService] Error rebuilding period cache $cacheKey: $e');
    }
  }

  /// 기간 내 일간 통계 로드 (getWeeklyStats/getMonthlyStats와 동일 로직)
  Future<dynamic> _loadPeriodStats(
    DateTime start,
    DateTime end,
    DateTime today,
  ) async {
    // start가 월의 1일이면 월간, 아니면 주간으로 판단
    if (start.day == 1 && end.day >= 28) {
      // 월간
      final result = await _analyticsRepository.getMonthlyStats(
        start.year,
        start.month,
      );
      return result.fold((failure) => [], (stats) => stats);
    } else {
      // 주간
      final result = await _analyticsRepository.getWeeklyStats(start);
      return result.fold((failure) => [], (stats) => stats);
    }
  }

  /// 날짜 범위의 통계를 일괄 재계산 (데모 데이터 시딩 등)
  ///
  /// 디바운스 없이 즉시 순차 실행합니다.
  /// 일간 통계를 모두 재계산한 뒤 관련 기간 캐시를 리빌드합니다.
  Future<void> recalculateRange(DateTime start, DateTime end) async {
    final normalizedStart = DateTime(start.year, start.month, start.day);
    final normalizedEnd = DateTime(end.year, end.month, end.day);
    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);

    debugPrint(
      '[StatsUpdateService] Bulk recalculating: '
      '${_dateKey(normalizedStart)} ~ ${_dateKey(normalizedEnd)}',
    );

    // 1. 미래 날짜 제외하고 일간 통계 순차 재계산
    var current = normalizedStart;
    while (!current.isAfter(normalizedEnd) &&
        !current.isAfter(normalizedToday)) {
      try {
        await _analyticsRepository.saveDailyStatsSummary(current);
      } catch (e) {
        debugPrint(
          '[StatsUpdateService] Bulk: error for ${_dateKey(current)}: $e',
        );
      }
      current = current.add(const Duration(days: 1));
    }

    // 2. 영향받는 주간/월간 기간 캐시 수집 후 리빌드
    final periodKeys = <String, (DateTime, DateTime)>{};
    current = normalizedStart;
    while (!current.isAfter(normalizedEnd)) {
      // 주간
      final weeklyKey = PeriodCacheModel.weeklyKey(current);
      if (!periodKeys.containsKey(weeklyKey)) {
        final wStart = current.subtract(Duration(days: current.weekday - 1));
        final wEnd = wStart.add(const Duration(days: 6));
        periodKeys[weeklyKey] = (wStart, wEnd);
      }
      // 월간
      final monthlyKey = PeriodCacheModel.monthlyKey(current);
      if (!periodKeys.containsKey(monthlyKey)) {
        final mStart = DateTime(current.year, current.month, 1);
        final mEnd = DateTime(current.year, current.month + 1, 0);
        periodKeys[monthlyKey] = (mStart, mEnd);
      }
      current = current.add(const Duration(days: 1));
    }

    for (final entry in periodKeys.entries) {
      await _rebuildSinglePeriodCache(
        cacheKey: entry.key,
        start: entry.value.$1,
        end: entry.value.$2,
      );
    }

    // 3. 완료 알림 (오늘 날짜 기준으로 한 번)
    if (!_controller.isClosed) {
      _controller.add(normalizedToday);
    }

    debugPrint('[StatsUpdateService] Bulk recalculation complete');
  }

  /// 모든 통계 캐시 삭제 (데모 데이터 제거 시)
  ///
  /// 기간별 캐시(주간/월간)와 일간 통계 요약을 모두 삭제합니다.
  Future<void> clearAllCaches() async {
    try {
      // 기간별 캐시 삭제
      await _analyticsDataSource.clearAllPeriodCaches();

      // 일간 통계 요약도 모두 삭제 (기존 데이터를 가져와서 삭제)
      final now = DateTime.now();
      final start = now.subtract(const Duration(days: 60));
      final end = now.add(const Duration(days: 7));
      final summaries =
          await _analyticsDataSource.getDailyStatsSummaryRange(start, end);
      for (final summary in summaries) {
        await _analyticsDataSource.deleteDailyStatsSummary(summary.date);
      }

      debugPrint('[StatsUpdateService] All caches cleared');
    } catch (e) {
      debugPrint('[StatsUpdateService] Error clearing caches: $e');
    }
  }

  /// 날짜를 키로 변환
  String _dateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// 리소스 정리
  void dispose() {
    for (final timer in _debounceTimers.values) {
      timer.cancel();
    }
    _debounceTimers.clear();
    _controller.close();
  }
}
