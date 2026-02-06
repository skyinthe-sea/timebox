import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/analytics_local_datasource.dart';
import '../../data/models/period_cache_model.dart';
import '../../domain/entities/daily_stats_summary.dart';
import '../../domain/entities/insight.dart';
import '../../domain/entities/productivity_stats.dart';
import '../../domain/entities/task_completion_ranking.dart';
import '../../domain/entities/time_comparison.dart';
import '../../domain/repositories/analytics_repository.dart';
import 'statistics_event.dart';
import 'statistics_state.dart';

/// Statistics BLoC
///
/// 통계 페이지의 상태 관리
class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final AnalyticsRepository _analyticsRepository;
  final AnalyticsLocalDataSource _localDataSource;

  StatisticsBloc({
    required AnalyticsRepository analyticsRepository,
    required AnalyticsLocalDataSource localDataSource,
  })  : _analyticsRepository = analyticsRepository,
        _localDataSource = localDataSource,
        super(StatisticsState.initial()) {
    on<LoadStatistics>(_onLoadStatistics);
    on<RefreshStatistics>(_onRefreshStatistics);
    on<ChangePeriod>(_onChangePeriod);
    on<SelectDate>(_onSelectDate);
    on<RefreshInsights>(_onRefreshInsights);
    on<PreloadStatistics>(_onPreloadStatistics);
  }

  Future<void> _onLoadStatistics(
    LoadStatistics event,
    Emitter<StatisticsState> emit,
  ) async {
    emit(state.copyWith(
      status: StatisticsStatus.loading,
      selectedDate: event.date,
      currentPeriod: event.period,
      // 새 날짜 선택 시 캐시 클리어
      weeklyCache: null,
      monthlyCache: null,
    ));

    try {
      final yesterday = event.date.subtract(const Duration(days: 1));
      final dailyRange = _getDateRange(event.date, StatsPeriod.daily);

      // 일간 기본 데이터 + 최소 필요 데이터만 빠르게 로드 (5개 쿼리)
      final results = await Future.wait([
        _analyticsRepository.getDailyStats(event.date),
        _analyticsRepository.getDailyStats(yesterday),
        _analyticsRepository.getDailyStatsSummary(event.date),
        _loadTagStats(event.date, StatsPeriod.daily),
        _analyticsRepository.getTaskPipelineStats(dailyRange.$1, dailyRange.$2),
      ]);

      final todayStats = (results[0] as dynamic).fold(
        (failure) => null,
        (stats) => stats,
      );
      final yesterdayStats = (results[1] as dynamic).fold(
        (failure) => null,
        (stats) => stats,
      );
      final dailySummary = (results[2] as dynamic).fold(
        (failure) => null,
        (summary) => summary,
      );
      final tagStats = results[3] as List<TagTimeComparison>;
      final pipelineStats = (results[4] as dynamic).fold(
        (failure) => null,
        (stats) => stats,
      );

      // 인사이트 생성
      final allInsights = _generateInsights(
        date: event.date,
        period: event.period,
        todayStats: todayStats,
        yesterdayStats: yesterdayStats,
        dailySummary: dailySummary,
        periodStats: const [],
      );
      final insights = allInsights.take(3).toList();

      // 즉시 UI 표시 (최소 데이터로)
      emit(state.copyWith(
        status: StatisticsStatus.loaded,
        todayStats: todayStats,
        yesterdayStats: yesterdayStats,
        dailySummary: dailySummary,
        periodStats: const [],
        tagStats: tagStats,
        pipelineStats: pipelineStats,
        periodSummaries: const [],
        timeComparisons: const [],
        topSuccessTasks: const [],
        topFailureTasks: const [],
        insights: insights,
        errorMessage: null,
      ));

      // 프리로드 제거 - 사용자가 탭 전환 시에만 해당 기간 데이터 로드
    } catch (e) {
      emit(state.copyWith(
        status: StatisticsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRefreshStatistics(
    RefreshStatistics event,
    Emitter<StatisticsState> emit,
  ) async {
    // 새로고침 시 캐시 클리어
    emit(state.copyWith(
      weeklyCache: null,
      monthlyCache: null,
    ));
    add(LoadStatistics(
      date: state.selectedDate,
      period: state.currentPeriod,
    ));
  }

  Future<void> _onChangePeriod(
    ChangePeriod event,
    Emitter<StatisticsState> emit,
  ) async {
    // 같은 기간이면 무시
    if (event.period == state.currentPeriod) return;

    // 1단계: 메모리 캐시 확인
    var cache = event.period == StatsPeriod.weekly
        ? state.weeklyCache
        : event.period == StatsPeriod.monthly
            ? state.monthlyCache
            : null;

    // 2단계: 메모리 캐시 미스 시 Hive 영구 캐시 확인
    if (cache == null && event.period != StatsPeriod.daily) {
      final cacheKey = event.period == StatsPeriod.weekly
          ? PeriodCacheModel.weeklyKey(state.selectedDate)
          : PeriodCacheModel.monthlyKey(state.selectedDate);

      final hiveCacheModel = await _localDataSource.getPeriodCache(cacheKey);
      if (hiveCacheModel != null) {
        debugPrint('[StatisticsBloc] Hive cache hit for: $cacheKey');
        cache = hiveCacheModel.toEntity();

        // 메모리 캐시에도 저장
        if (event.period == StatsPeriod.weekly) {
          emit(state.copyWith(weeklyCache: cache));
        } else {
          emit(state.copyWith(monthlyCache: cache));
        }
      }
    }

    if (cache != null) {
      // 캐시 히트: 즉시 전환 (로딩 없음)
      final allInsights = _generateInsights(
        date: state.selectedDate,
        period: event.period,
        todayStats: state.todayStats,
        yesterdayStats: state.yesterdayStats,
        dailySummary: state.dailySummary,
        periodStats: cache.periodStats,
      );
      final insights = allInsights.take(3).toList();

      emit(state.copyWith(
        currentPeriod: event.period,
        periodStats: cache.periodStats,
        tagStats: cache.tagStats,
        pipelineStats: cache.pipelineStats,
        periodSummaries: cache.periodSummaries,
        timeComparisons: cache.timeComparisons,
        topSuccessTasks: cache.topSuccessTasks,
        topFailureTasks: cache.topFailureTasks,
        insights: insights,
      ));
      return;
    }

    // 캐시 미스: 로딩 표시 후 데이터 로드
    debugPrint('[StatisticsBloc] Cache miss for ${event.period}, loading data...');
    emit(state.copyWith(
      status: StatisticsStatus.loading,
      currentPeriod: event.period,
    ));

    try {
      final periodData = await _loadPeriodData(state.selectedDate, event.period);

      final allInsights = _generateInsights(
        date: state.selectedDate,
        period: event.period,
        todayStats: state.todayStats,
        yesterdayStats: state.yesterdayStats,
        dailySummary: state.dailySummary,
        periodStats: periodData.periodStats,
      );
      final insights = allInsights.take(3).toList();

      // 메모리 캐시에 저장
      final newCache = PeriodCache(
        periodStats: periodData.periodStats,
        tagStats: periodData.tagStats,
        pipelineStats: periodData.pipelineStats,
        periodSummaries: periodData.periodSummaries,
        timeComparisons: periodData.timeComparisons,
        topSuccessTasks: periodData.topSuccessTasks,
        topFailureTasks: periodData.topFailureTasks,
      );

      // Hive 영구 캐시에도 저장
      if (event.period == StatsPeriod.weekly || event.period == StatsPeriod.monthly) {
        final cacheKey = event.period == StatsPeriod.weekly
            ? PeriodCacheModel.weeklyKey(state.selectedDate)
            : PeriodCacheModel.monthlyKey(state.selectedDate);

        final cacheModel = PeriodCacheModel.fromEntity(
          cacheKey: cacheKey,
          cache: newCache,
        );
        await _localDataSource.savePeriodCache(cacheModel);
      }

      emit(state.copyWith(
        status: StatisticsStatus.loaded,
        periodStats: periodData.periodStats,
        tagStats: periodData.tagStats,
        pipelineStats: periodData.pipelineStats,
        periodSummaries: periodData.periodSummaries,
        timeComparisons: periodData.timeComparisons,
        topSuccessTasks: periodData.topSuccessTasks,
        topFailureTasks: periodData.topFailureTasks,
        insights: insights,
        weeklyCache: event.period == StatsPeriod.weekly ? newCache : state.weeklyCache,
        monthlyCache: event.period == StatsPeriod.monthly ? newCache : state.monthlyCache,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: StatisticsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onSelectDate(
    SelectDate event,
    Emitter<StatisticsState> emit,
  ) async {
    add(LoadStatistics(
      date: event.date,
      period: state.currentPeriod,
    ));
  }

  Future<void> _onRefreshInsights(
    RefreshInsights event,
    Emitter<StatisticsState> emit,
  ) async {
    final insights = _generateInsights(
      date: state.selectedDate,
      period: state.currentPeriod,
      todayStats: state.todayStats,
      yesterdayStats: state.yesterdayStats,
      dailySummary: state.dailySummary,
      periodStats: state.periodStats,
    );
    emit(state.copyWith(insights: insights));
  }

  /// 통계 데이터 백그라운드 프리로드
  ///
  /// CalendarPage에서 호출되어 통계 데이터를 미리 로드
  /// - 이미 로드된 상태면 스킵
  /// - 일간 데이터 로드 후 주간/월간 캐시 프리로드
  Future<void> _onPreloadStatistics(
    PreloadStatistics event,
    Emitter<StatisticsState> emit,
  ) async {
    // 이미 로드된 상태면 캐시만 프리로드
    if (state.status == StatisticsStatus.loaded) {
      await _preloadPeriodCaches(event.date, emit);
      return;
    }

    // 일간 데이터 먼저 로드 (UI 표시용이 아니므로 로딩 상태 없음)
    try {
      final yesterday = event.date.subtract(const Duration(days: 1));
      final dailyRange = _getDateRange(event.date, StatsPeriod.daily);

      final results = await Future.wait([
        _analyticsRepository.getDailyStats(event.date),
        _analyticsRepository.getDailyStats(yesterday),
        _analyticsRepository.getDailyStatsSummary(event.date),
        _loadTagStats(event.date, StatsPeriod.daily),
        _analyticsRepository.getTaskPipelineStats(dailyRange.$1, dailyRange.$2),
      ]);

      final todayStats = (results[0] as dynamic).fold(
        (failure) => null,
        (stats) => stats,
      );
      final yesterdayStats = (results[1] as dynamic).fold(
        (failure) => null,
        (stats) => stats,
      );
      final dailySummary = (results[2] as dynamic).fold(
        (failure) => null,
        (summary) => summary,
      );
      final tagStats = results[3] as List<TagTimeComparison>;
      final pipelineStats = (results[4] as dynamic).fold(
        (failure) => null,
        (stats) => stats,
      );

      final allInsights = _generateInsights(
        date: event.date,
        period: StatsPeriod.daily,
        todayStats: todayStats,
        yesterdayStats: yesterdayStats,
        dailySummary: dailySummary,
        periodStats: const [],
      );
      final insights = allInsights.take(3).toList();

      emit(state.copyWith(
        status: StatisticsStatus.loaded,
        selectedDate: event.date,
        todayStats: todayStats,
        yesterdayStats: yesterdayStats,
        dailySummary: dailySummary,
        periodStats: const [],
        tagStats: tagStats,
        pipelineStats: pipelineStats,
        periodSummaries: const [],
        timeComparisons: const [],
        topSuccessTasks: const [],
        topFailureTasks: const [],
        insights: insights,
        errorMessage: null,
      ));

      // 주간/월간 캐시 프리로드 (백그라운드)
      await _preloadPeriodCaches(event.date, emit);
    } catch (e) {
      // 프리로드 실패는 무시 (통계 페이지 진입 시 재로드)
    }
  }

  /// 주간/월간 캐시 프리로드 (백그라운드)
  ///
  /// 1. Hive 영구 캐시 확인
  /// 2. 캐시 미스 시 데이터 로드 후 Hive에 저장
  Future<void> _preloadPeriodCaches(
    DateTime date,
    Emitter<StatisticsState> emit,
  ) async {
    // 짧은 딜레이 후 캐시 프리로드 (UI 렌더링 우선)
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      // 주간 캐시 프리로드
      if (state.weeklyCache == null && !isClosed) {
        debugPrint('[StatisticsBloc] Preloading weekly cache...');
        final weeklyKey = PeriodCacheModel.weeklyKey(date);

        // 1. Hive 영구 캐시 확인
        final hiveCacheModel = await _localDataSource.getPeriodCache(weeklyKey);
        PeriodCache? weeklyCache;

        if (hiveCacheModel != null) {
          // Hive 캐시 히트
          debugPrint('[StatisticsBloc] Weekly Hive cache hit: $weeklyKey');
          weeklyCache = hiveCacheModel.toEntity();
        } else {
          // 캐시 미스 - 데이터 로드
          debugPrint('[StatisticsBloc] Weekly Hive cache miss, loading data...');
          final weeklyData = await _loadPeriodData(date, StatsPeriod.weekly);
          weeklyCache = PeriodCache(
            periodStats: weeklyData.periodStats,
            tagStats: weeklyData.tagStats,
            pipelineStats: weeklyData.pipelineStats,
            periodSummaries: weeklyData.periodSummaries,
            timeComparisons: weeklyData.timeComparisons,
            topSuccessTasks: weeklyData.topSuccessTasks,
            topFailureTasks: weeklyData.topFailureTasks,
          );

          // Hive에 영구 저장
          final cacheModel = PeriodCacheModel.fromEntity(
            cacheKey: weeklyKey,
            cache: weeklyCache,
          );
          await _localDataSource.savePeriodCache(cacheModel);
        }

        if (!isClosed) {
          emit(state.copyWith(weeklyCache: weeklyCache));
          debugPrint('[StatisticsBloc] Weekly cache loaded');
        }
      }

      // 월간 캐시 프리로드
      if (state.monthlyCache == null && !isClosed) {
        debugPrint('[StatisticsBloc] Preloading monthly cache...');
        final monthlyKey = PeriodCacheModel.monthlyKey(date);

        // 1. Hive 영구 캐시 확인
        final hiveCacheModel = await _localDataSource.getPeriodCache(monthlyKey);
        PeriodCache? monthlyCache;

        if (hiveCacheModel != null) {
          // Hive 캐시 히트
          debugPrint('[StatisticsBloc] Monthly Hive cache hit: $monthlyKey');
          monthlyCache = hiveCacheModel.toEntity();
        } else {
          // 캐시 미스 - 데이터 로드
          debugPrint('[StatisticsBloc] Monthly Hive cache miss, loading data...');
          final monthlyData = await _loadPeriodData(date, StatsPeriod.monthly);
          monthlyCache = PeriodCache(
            periodStats: monthlyData.periodStats,
            tagStats: monthlyData.tagStats,
            pipelineStats: monthlyData.pipelineStats,
            periodSummaries: monthlyData.periodSummaries,
            timeComparisons: monthlyData.timeComparisons,
            topSuccessTasks: monthlyData.topSuccessTasks,
            topFailureTasks: monthlyData.topFailureTasks,
          );

          // Hive에 영구 저장
          final cacheModel = PeriodCacheModel.fromEntity(
            cacheKey: monthlyKey,
            cache: monthlyCache,
          );
          await _localDataSource.savePeriodCache(cacheModel);
        }

        if (!isClosed) {
          emit(state.copyWith(monthlyCache: monthlyCache));
          debugPrint('[StatisticsBloc] Monthly cache loaded');
        }
      }

      debugPrint('[StatisticsBloc] Preload complete!');
    } catch (e) {
      debugPrint('[StatisticsBloc] Preload failed: $e');
    }
  }

  /// 기간별 모든 데이터 로드 (병렬)
  Future<_PeriodData> _loadPeriodData(DateTime date, StatsPeriod period) async {
    final dateRange = _getDateRange(date, period);

    final results = await Future.wait([
      _loadPeriodStats(date, period),
      _loadTagStats(date, period),
      _analyticsRepository.getTaskPipelineStats(dateRange.$1, dateRange.$2),
      _analyticsRepository.getTimeComparisons(dateRange.$1, dateRange.$2),
      _analyticsRepository.getTaskCompletionRankings(dateRange.$1, dateRange.$2),
      if (period != StatsPeriod.daily)
        _analyticsRepository.getDailyStatsSummaries(dateRange.$1, dateRange.$2),
    ]);

    final periodStats = results[0] as List<ProductivityStats>;
    final tagStats = results[1] as List<TagTimeComparison>;
    final pipelineStats = (results[2] as dynamic).fold(
      (failure) => null,
      (stats) => stats,
    );
    final timeComparisons = (results[3] as dynamic).fold(
      (failure) => <TimeComparison>[],
      (comparisons) => comparisons,
    );
    final rankingsResult = results[4];
    final topSuccessTasks = (rankingsResult as dynamic).fold(
      (failure) => <TaskCompletionRanking>[],
      (rankings) => rankings.topSuccess,
    );
    final topFailureTasks = (rankingsResult as dynamic).fold(
      (failure) => <TaskCompletionRanking>[],
      (rankings) => rankings.topFailure,
    );

    List<DailyStatsSummary> periodSummaries = [];
    if (period != StatsPeriod.daily && results.length > 5) {
      periodSummaries = (results[5] as dynamic).fold(
        (failure) => <DailyStatsSummary>[],
        (summaries) => summaries,
      );
    }

    return _PeriodData(
      periodStats: periodStats,
      tagStats: tagStats,
      pipelineStats: pipelineStats,
      periodSummaries: periodSummaries,
      timeComparisons: timeComparisons,
      topSuccessTasks: topSuccessTasks,
      topFailureTasks: topFailureTasks,
    );
  }

  /// 기간별 통계 로드
  Future<List<ProductivityStats>> _loadPeriodStats(
    DateTime date,
    StatsPeriod period,
  ) async {
    switch (period) {
      case StatsPeriod.daily:
        return [];
      case StatsPeriod.weekly:
        final weekStart = date.subtract(Duration(days: date.weekday - 1));
        final result = await _analyticsRepository.getWeeklyStats(weekStart);
        return result.fold((failure) => [], (stats) => stats);
      case StatsPeriod.monthly:
        final result = await _analyticsRepository.getMonthlyStats(
          date.year,
          date.month,
        );
        return result.fold((failure) => [], (stats) => stats);
    }
  }

  /// 기간에 따른 날짜 범위 계산
  (DateTime, DateTime) _getDateRange(DateTime date, StatsPeriod period) {
    switch (period) {
      case StatsPeriod.daily:
        final start = DateTime(date.year, date.month, date.day);
        return (start, start);
      case StatsPeriod.weekly:
        final start = date.subtract(Duration(days: date.weekday - 1));
        final end = start.add(const Duration(days: 6));
        return (start, end);
      case StatsPeriod.monthly:
        final start = DateTime(date.year, date.month, 1);
        final end = DateTime(date.year, date.month + 1, 0);
        return (start, end);
    }
  }

  /// 태그별 통계 로드
  Future<List<TagTimeComparison>> _loadTagStats(
    DateTime date,
    StatsPeriod period,
  ) async {
    final range = _getDateRange(date, period);
    final result = await _analyticsRepository.getTagStatistics(range.$1, range.$2);
    return result.fold((failure) => [], (stats) => stats);
  }

  /// 요일 인덱스 → l10n 키
  String _weekdayKey(int weekday) {
    const keys = ['', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'];
    return keys[weekday];
  }

  /// 인사이트 생성 (키 기반 — 하드코딩 문자열 없음)
  List<Insight> _generateInsights({
    required DateTime date,
    required StatsPeriod period,
    ProductivityStats? todayStats,
    ProductivityStats? yesterdayStats,
    DailyStatsSummary? dailySummary,
    List<ProductivityStats> periodStats = const [],
  }) {
    final insights = <Insight>[];
    final now = DateTime.now();

    // === 일간(Daily) 인사이트 ===

    // 1. 점수 변화 (어제 대비)
    if (todayStats != null && yesterdayStats != null) {
      final scoreDiff = todayStats.score - yesterdayStats.score;
      if (scoreDiff.abs() >= 1) {
        insights.add(Insight.productivityChange(
          id: 'insight_score_${now.millisecondsSinceEpoch}',
          scoreDiff: scoreDiff,
          periodKey: 'insightPeriodYesterday',
        ));
      }
    }

    // 2. Task 완료율
    if (dailySummary != null && dailySummary.totalPlannedTasks > 0) {
      insights.add(Insight.taskCompletion(
        id: 'insight_taskcomp_${now.millisecondsSinceEpoch}',
        completed: dailySummary.completedTasks,
        total: dailySummary.totalPlannedTasks,
      ));
    }

    // 3. 시간 절약/초과
    if (dailySummary != null &&
        dailySummary.totalActualDuration.inMinutes > 0) {
      final savedMinutes = dailySummary.timeDifferenceMinutes;
      if (savedMinutes >= 5) {
        insights.add(Insight.timeSaved(
          id: 'insight_timesaved_${now.millisecondsSinceEpoch}',
          minutesSaved: savedMinutes,
          periodKey: 'insightPeriodToday',
        ));
      } else if (savedMinutes <= -5) {
        insights.add(Insight.timeOver(
          id: 'insight_timeover_${now.millisecondsSinceEpoch}',
          minutesOver: savedMinutes.abs(),
          periodKey: 'insightPeriodToday',
        ));
      }
    }

    // 4. 시간 예측 정확도
    if (dailySummary != null &&
        dailySummary.totalPlannedDuration.inMinutes > 0 &&
        dailySummary.totalActualDuration.inMinutes > 0) {
      final accuracy = dailySummary.timeAccuracy.round();
      insights.add(Insight.timeEstimation(
        id: 'insight_timeest_${now.millisecondsSinceEpoch}',
        accuracyPercent: accuracy,
      ));
    }

    // 5. 집중 효율
    if (dailySummary != null && dailySummary.focusSessionCount > 0) {
      final efficiency = dailySummary.focusEfficiency.round();
      insights.add(Insight.focusEfficiency(
        id: 'insight_focuseff_${now.millisecondsSinceEpoch}',
        efficiencyPercent: efficiency,
        focusMinutes: dailySummary.totalFocusDuration.inMinutes,
      ));
    }

    // 6. 이월 경고
    if (dailySummary != null && dailySummary.rolledOverTasks >= 2) {
      insights.add(Insight.rolloverWarning(
        id: 'insight_rollover_${now.millisecondsSinceEpoch}',
        rolloverCount: 2,
        taskCount: dailySummary.rolledOverTasks,
      ));
    }

    // 7. Top 3 달성
    if (dailySummary != null && dailySummary.top3CompletedCount > 0) {
      if (dailySummary.top3CompletedCount == 3) {
        insights.add(Insight(
          id: 'insight_top3_${now.millisecondsSinceEpoch}',
          type: InsightType.completionRate,
          priority: InsightPriority.high,
          titleKey: 'insightTop3AllCompleteTitle',
          descriptionKey: 'insightTop3AllCompleteDesc',
          value: 3,
          unitKey: 'insightUnitCount',
          iconCodePoint: 0xe838,
          isPositive: true,
          createdAt: now,
        ));
      } else {
        insights.add(Insight(
          id: 'insight_top3_${now.millisecondsSinceEpoch}',
          type: InsightType.completionRate,
          priority: InsightPriority.medium,
          titleKey: 'insightTop3PartialTitle',
          descriptionKey: 'insightTop3PartialDesc',
          params: {
            'completed': '${dailySummary.top3CompletedCount}',
            'remaining': '${3 - dailySummary.top3CompletedCount}',
          },
          value: dailySummary.top3CompletedCount.toDouble(),
          unitKey: 'insightUnitCount',
          iconCodePoint: 0xe838,
          isPositive: true,
          createdAt: now,
        ));
      }
    }

    // 8. 점수 기반 메시지
    if (todayStats != null) {
      if (todayStats.score >= 80) {
        insights.add(Insight(
          id: 'insight_great_${now.millisecondsSinceEpoch}',
          type: InsightType.completionRate,
          priority: InsightPriority.low,
          titleKey: 'insightScoreGreatTitle',
          descriptionKey: 'insightScoreGreatDesc',
          params: {'score': '${todayStats.score}'},
          value: todayStats.score.toDouble(),
          unitKey: 'insightUnitPoints',
          iconCodePoint: 0xe838,
          isPositive: true,
          createdAt: now,
        ));
      } else if (todayStats.score >= 50) {
        insights.add(Insight(
          id: 'insight_normal_${now.millisecondsSinceEpoch}',
          type: InsightType.completionRate,
          priority: InsightPriority.low,
          titleKey: 'insightScoreNormalTitle',
          descriptionKey: 'insightScoreNormalDesc',
          params: {'score': '${todayStats.score}'},
          value: todayStats.score.toDouble(),
          unitKey: 'insightUnitPoints',
          iconCodePoint: 0xe5cd,
          isPositive: true,
          createdAt: now,
        ));
      }
    }

    // === 주간(Weekly) 인사이트 ===
    if (period == StatsPeriod.weekly && periodStats.isNotEmpty) {
      final validStats = periodStats.where((s) => s.score > 0).toList();

      if (validStats.isNotEmpty) {
        // 9. 주간 평균 점수
        final avgScore =
            validStats.fold<int>(0, (sum, s) => sum + s.score) /
                validStats.length;
        insights.add(Insight(
          id: 'insight_weekavg_${now.millisecondsSinceEpoch}',
          type: InsightType.completionRate,
          priority: InsightPriority.medium,
          titleKey: 'insightWeekAvgTitle',
          descriptionKey: avgScore >= 70
              ? 'insightWeekAvgHighDesc'
              : 'insightWeekAvgLowDesc',
          params: {'score': '${avgScore.round()}'},
          value: avgScore,
          unitKey: 'insightUnitPoints',
          iconCodePoint: 0xe1b1,
          isPositive: avgScore >= 50,
          createdAt: now,
        ));

        // 10. 가장 생산적인 요일
        final best = validStats.reduce(
          (a, b) => a.score >= b.score ? a : b,
        );
        final dayKey = _weekdayKey(best.date.weekday);
        insights.add(Insight.bestDay(
          id: 'insight_bestday_${now.millisecondsSinceEpoch}',
          dayKey: dayKey,
          avgScore: best.score.toDouble(),
        ));

        // 11. 주간 트렌드 (전반부 vs 후반부)
        if (validStats.length >= 4) {
          final half = validStats.length ~/ 2;
          final firstHalf = validStats.sublist(0, half);
          final secondHalf = validStats.sublist(half);

          final firstAvg =
              firstHalf.fold<int>(0, (sum, s) => sum + s.score) /
                  firstHalf.length;
          final secondAvg =
              secondHalf.fold<int>(0, (sum, s) => sum + s.score) /
                  secondHalf.length;

          final diff = secondAvg - firstAvg;
          if (diff.abs() >= 5) {
            insights.add(Insight.productivityChange(
              id: 'insight_weektrend_${now.millisecondsSinceEpoch}',
              scoreDiff: diff.round(),
              periodKey: 'insightPeriodWeekFirstHalf',
            ));
          }
        }
      }
    }

    // === 월간(Monthly) 인사이트 ===
    if (period == StatsPeriod.monthly && periodStats.isNotEmpty) {
      final validStats = periodStats.where((s) => s.score > 0).toList();

      if (validStats.isNotEmpty) {
        // 12. 월간 평균 점수
        final avgScore =
            validStats.fold<int>(0, (sum, s) => sum + s.score) /
                validStats.length;
        insights.add(Insight(
          id: 'insight_monthavg_${now.millisecondsSinceEpoch}',
          type: InsightType.completionRate,
          priority: InsightPriority.medium,
          titleKey: 'insightMonthAvgTitle',
          descriptionKey: avgScore >= 70
              ? 'insightMonthAvgHighDesc'
              : 'insightMonthAvgLowDesc',
          params: {'score': '${avgScore.round()}'},
          value: avgScore,
          unitKey: 'insightUnitPoints',
          iconCodePoint: 0xe1b1,
          isPositive: avgScore >= 50,
          createdAt: now,
        ));

        // 13. 월간 최고의 날
        final best = validStats.reduce(
          (a, b) => a.score >= b.score ? a : b,
        );
        insights.add(Insight(
          id: 'insight_monthbest_${now.millisecondsSinceEpoch}',
          type: InsightType.bestDay,
          priority: InsightPriority.medium,
          titleKey: 'insightMonthBestTitle',
          descriptionKey: 'insightMonthBestDesc',
          params: {
            'month': '${best.date.month}',
            'day': '${best.date.day}',
            'score': '${best.score}',
          },
          value: best.score.toDouble(),
          unitKey: 'insightUnitPoints',
          iconCodePoint: 0xe838,
          isPositive: true,
          createdAt: now,
        ));
      }
    }

    // 인사이트가 전혀 없으면 기본 메시지 추가
    if (insights.isEmpty) {
      insights.add(Insight(
        id: 'insight_default_${now.millisecondsSinceEpoch}',
        type: InsightType.completionRate,
        priority: InsightPriority.low,
        titleKey: 'insightTaskFirstTitle',
        descriptionKey: 'insightTaskFirstDesc',
        iconCodePoint: 0xe8b5,
        isPositive: true,
        createdAt: now,
      ));
    }

    return insights;
  }
}

/// 기간별 데이터 래퍼
class _PeriodData {
  final List<ProductivityStats> periodStats;
  final List<TagTimeComparison> tagStats;
  final dynamic pipelineStats;
  final List<DailyStatsSummary> periodSummaries;
  final List<TimeComparison> timeComparisons;
  final List<TaskCompletionRanking> topSuccessTasks;
  final List<TaskCompletionRanking> topFailureTasks;

  const _PeriodData({
    required this.periodStats,
    required this.tagStats,
    this.pipelineStats,
    required this.periodSummaries,
    required this.timeComparisons,
    required this.topSuccessTasks,
    required this.topFailureTasks,
  });
}
