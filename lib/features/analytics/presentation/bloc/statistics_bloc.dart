import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/daily_stats_summary.dart';
import '../../domain/entities/insight.dart';
import '../../domain/entities/productivity_stats.dart';
import '../../domain/entities/time_comparison.dart';
import '../../domain/repositories/analytics_repository.dart';
import 'statistics_event.dart';
import 'statistics_state.dart';

/// Statistics BLoC
///
/// 통계 페이지의 상태 관리
class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final AnalyticsRepository _analyticsRepository;

  StatisticsBloc({
    required AnalyticsRepository analyticsRepository,
  })  : _analyticsRepository = analyticsRepository,
        super(StatisticsState.initial()) {
    on<LoadStatistics>(_onLoadStatistics);
    on<RefreshStatistics>(_onRefreshStatistics);
    on<ChangePeriod>(_onChangePeriod);
    on<SelectDate>(_onSelectDate);
    on<RefreshInsights>(_onRefreshInsights);
  }

  Future<void> _onLoadStatistics(
    LoadStatistics event,
    Emitter<StatisticsState> emit,
  ) async {
    emit(state.copyWith(
      status: StatisticsStatus.loading,
      selectedDate: event.date,
      currentPeriod: event.period,
    ));

    try {
      // 오늘 통계 로드
      final todayResult = await _analyticsRepository.getDailyStats(event.date);
      final todayStats = todayResult.fold(
        (failure) => null,
        (stats) => stats,
      );

      // 어제 통계 로드 (비교용)
      final yesterday = event.date.subtract(const Duration(days: 1));
      final yesterdayResult = await _analyticsRepository.getDailyStats(yesterday);
      final yesterdayStats = yesterdayResult.fold(
        (failure) => null,
        (stats) => stats,
      );

      // 기간별 통계 로드
      final periodStats = await _loadPeriodStats(event.date, event.period);

      // 태그별 통계 로드
      final tagStats = await _loadTagStats(event.date, event.period);

      // 히트맵 데이터 로드 (주간/월간만) - 현재 미구현
      // await _loadHourlyProductivity(event.date, event.period);

      // 일간 요약 로드 (Top3 달성 등)
      final summaryResult = await _analyticsRepository.getDailyStatsSummary(event.date);
      final dailySummary = summaryResult.fold(
        (failure) => null,
        (summary) => summary,
      );

      // 인사이트 생성 (로드된 데이터 전달)
      final insights = await _generateInsights(
        date: event.date,
        todayStats: todayStats,
        yesterdayStats: yesterdayStats,
        dailySummary: dailySummary,
      );

      emit(state.copyWith(
        status: StatisticsStatus.loaded,
        todayStats: todayStats,
        yesterdayStats: yesterdayStats,
        periodStats: periodStats,
        tagStats: tagStats,
        dailySummary: dailySummary,
        insights: insights,
        errorMessage: null,
      ));
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
    add(LoadStatistics(
      date: state.selectedDate,
      period: state.currentPeriod,
    ));
  }

  Future<void> _onChangePeriod(
    ChangePeriod event,
    Emitter<StatisticsState> emit,
  ) async {
    add(LoadStatistics(
      date: state.selectedDate,
      period: event.period,
    ));
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
    final insights = await _generateInsights(
      date: state.selectedDate,
      todayStats: state.todayStats,
      yesterdayStats: state.yesterdayStats,
      dailySummary: state.dailySummary,
    );
    emit(state.copyWith(insights: insights));
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

  /// 태그별 통계 로드
  Future<List<TagTimeComparison>> _loadTagStats(
    DateTime date,
    StatsPeriod period,
  ) async {
    DateTime start;
    DateTime end;

    switch (period) {
      case StatsPeriod.daily:
        start = DateTime(date.year, date.month, date.day);
        end = start;
        break;
      case StatsPeriod.weekly:
        start = date.subtract(Duration(days: date.weekday - 1));
        end = start.add(const Duration(days: 6));
        break;
      case StatsPeriod.monthly:
        start = DateTime(date.year, date.month, 1);
        end = DateTime(date.year, date.month + 1, 0);
        break;
    }

    final result = await _analyticsRepository.getTagStatistics(start, end);
    return result.fold((failure) => [], (stats) => stats);
  }

  /// 인사이트 생성
  Future<List<Insight>> _generateInsights({
    required DateTime date,
    ProductivityStats? todayStats,
    ProductivityStats? yesterdayStats,
    DailyStatsSummary? dailySummary,
  }) async {
    final insights = <Insight>[];
    final now = DateTime.now();

    // 1. 어제 대비 점수 변화 인사이트 (조건 완화: 1점 이상 차이)
    if (todayStats != null && yesterdayStats != null) {
      final scoreDiff = todayStats.score - yesterdayStats.score;
      if (scoreDiff.abs() >= 1) {
        insights.add(Insight.productivityChange(
          id: 'insight_score_${now.millisecondsSinceEpoch}',
          scoreDiff: scoreDiff,
          periodText: '어제',
        ));
      }
    }

    // 2. 이월 경고 (dailySummary에서 이월된 태스크 확인)
    if (dailySummary != null && dailySummary.rolledOverTasks >= 3) {
      insights.add(Insight.rolloverWarning(
        id: 'insight_rollover_${now.millisecondsSinceEpoch}',
        rolloverCount: 3,
        taskCount: dailySummary.rolledOverTasks,
      ));
    }

    // 3. 시간 절약 (예상 시간보다 빨리 완료한 경우)
    if (dailySummary != null && dailySummary.totalPlannedDuration.inMinutes > 0) {
      final savedMinutes = dailySummary.timeDifferenceMinutes;
      if (savedMinutes >= 10) {
        insights.add(Insight.timeSaved(
          id: 'insight_timesaved_${now.millisecondsSinceEpoch}',
          minutesSaved: savedMinutes,
          periodText: '오늘',
        ));
      }
    }

    // 4. Top3 달성 축하 (Top3 전부 완료 시)
    if (dailySummary != null && dailySummary.top3CompletedCount == 3) {
      insights.add(Insight.streak(
        id: 'insight_top3_${now.millisecondsSinceEpoch}',
        days: 1, // Top3 달성을 streak로 표현
      ));
    }

    // 5. 완료율 기반 인사이트 (오늘 통계가 있는 경우)
    if (todayStats != null) {
      // 점수가 높으면 칭찬 메시지
      if (todayStats.score >= 80) {
        insights.add(Insight(
          id: 'insight_great_${now.millisecondsSinceEpoch}',
          type: InsightType.completionRate,
          priority: InsightPriority.medium,
          title: '오늘 생산성이 아주 높아요!',
          description: '${todayStats.score}점을 달성했어요. 대단해요!',
          value: todayStats.score.toDouble(),
          unit: '점',
          iconCodePoint: 0xe838, // Icons.star
          isPositive: true,
          createdAt: now,
        ));
      } else if (todayStats.score >= 50 && insights.isEmpty) {
        // 다른 인사이트가 없고 점수가 보통일 때 기본 인사이트
        insights.add(Insight(
          id: 'insight_normal_${now.millisecondsSinceEpoch}',
          type: InsightType.completionRate,
          priority: InsightPriority.low,
          title: '오늘도 꾸준히 진행 중이에요',
          description: '현재 ${todayStats.score}점이에요. 조금만 더 힘내봐요!',
          value: todayStats.score.toDouble(),
          unit: '점',
          iconCodePoint: 0xe5cd, // Icons.check
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
        title: '오늘의 첫 번째 Task를 시작해보세요!',
        description: '작은 성취가 큰 변화를 만들어요.',
        iconCodePoint: 0xe8b5, // Icons.lightbulb_outline
        isPositive: true,
        createdAt: now,
      ));
    }

    return insights;
  }
}
