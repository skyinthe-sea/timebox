import 'package:flutter_bloc/flutter_bloc.dart';

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

      // 기간 범위 계산
      final dateRange = _getDateRange(event.date, event.period);

      // 일간 요약 로드 (Top3 달성 등)
      final summaryResult = await _analyticsRepository.getDailyStatsSummary(event.date);
      final dailySummary = summaryResult.fold(
        (failure) => null,
        (summary) => summary,
      );

      // Task Pipeline 통계 로드
      final pipelineResult = await _analyticsRepository.getTaskPipelineStats(
        dateRange.$1,
        dateRange.$2,
      );
      final pipelineStats = pipelineResult.fold(
        (failure) => null,
        (stats) => stats,
      );

      // 우선순위별 통계 로드
      final priorityResult = await _analyticsRepository.getPriorityBreakdownStats(
        dateRange.$1,
        dateRange.$2,
      );
      final priorityBreakdown = priorityResult.fold(
        (failure) => null,
        (stats) => stats,
      );

      // 계획 vs 실제 시간 비교 로드
      final timeCompResult = await _analyticsRepository.getTimeComparisons(
        dateRange.$1,
        dateRange.$2,
      );
      final timeComparisons = timeCompResult.fold(
        (failure) => <TimeComparison>[],
        (comparisons) => comparisons,
      );

      // Task 완료 랭킹 로드
      final rankingsResult = await _analyticsRepository.getTaskCompletionRankings(
        dateRange.$1,
        dateRange.$2,
      );
      final topSuccessTasks = rankingsResult.fold(
        (failure) => <TaskCompletionRanking>[],
        (rankings) => rankings.topSuccess,
      );
      final topFailureTasks = rankingsResult.fold(
        (failure) => <TaskCompletionRanking>[],
        (rankings) => rankings.topFailure,
      );

      // 인사이트 생성 (최대 3개로 제한)
      final allInsights = _generateInsights(
        date: event.date,
        period: event.period,
        todayStats: todayStats,
        yesterdayStats: yesterdayStats,
        dailySummary: dailySummary,
        periodStats: periodStats,
      );
      final insights = allInsights.take(3).toList();

      emit(state.copyWith(
        status: StatisticsStatus.loaded,
        todayStats: todayStats,
        yesterdayStats: yesterdayStats,
        periodStats: periodStats,
        tagStats: tagStats,
        dailySummary: dailySummary,
        pipelineStats: pipelineStats,
        priorityBreakdown: priorityBreakdown,
        timeComparisons: timeComparisons,
        topSuccessTasks: topSuccessTasks,
        topFailureTasks: topFailureTasks,
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
