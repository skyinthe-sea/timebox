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
      final allInsights = await _generateInsights(
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
    final insights = await _generateInsights(
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

  /// 인사이트 생성
  Future<List<Insight>> _generateInsights({
    required DateTime date,
    required StatsPeriod period,
    ProductivityStats? todayStats,
    ProductivityStats? yesterdayStats,
    DailyStatsSummary? dailySummary,
    List<ProductivityStats> periodStats = const [],
  }) async {
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
          periodText: '어제',
        ));
      }
    }

    // 2. Task 완료율 (신규)
    if (dailySummary != null && dailySummary.totalPlannedTasks > 0) {
      insights.add(Insight.taskCompletion(
        id: 'insight_taskcomp_${now.millisecondsSinceEpoch}',
        completed: dailySummary.completedTasks,
        total: dailySummary.totalPlannedTasks,
      ));
    }

    // 3. 시간 절약/초과 (버그 수정: 실제 데이터 있는 블록만)
    if (dailySummary != null &&
        dailySummary.totalActualDuration.inMinutes > 0) {
      final savedMinutes = dailySummary.timeDifferenceMinutes;
      if (savedMinutes >= 5) {
        // 절약
        insights.add(Insight.timeSaved(
          id: 'insight_timesaved_${now.millisecondsSinceEpoch}',
          minutesSaved: savedMinutes,
          periodText: '오늘',
        ));
      } else if (savedMinutes <= -5) {
        // 초과
        insights.add(Insight.timeOver(
          id: 'insight_timeover_${now.millisecondsSinceEpoch}',
          minutesOver: savedMinutes.abs(),
          periodText: '오늘',
        ));
      }
    }

    // 4. 시간 예측 정확도 (신규)
    if (dailySummary != null &&
        dailySummary.totalPlannedDuration.inMinutes > 0 &&
        dailySummary.totalActualDuration.inMinutes > 0) {
      final accuracy = dailySummary.timeAccuracy.round();
      insights.add(Insight.timeEstimation(
        id: 'insight_timeest_${now.millisecondsSinceEpoch}',
        accuracyPercent: accuracy,
      ));
    }

    // 5. 집중 효율 (신규)
    if (dailySummary != null && dailySummary.focusSessionCount > 0) {
      final efficiency = dailySummary.focusEfficiency.round();
      insights.add(Insight.focusEfficiency(
        id: 'insight_focuseff_${now.millisecondsSinceEpoch}',
        efficiencyPercent: efficiency,
        focusMinutes: dailySummary.totalFocusDuration.inMinutes,
      ));
    }

    // 6. 이월 경고 (기존, 조건 완화: 2개 이상)
    if (dailySummary != null && dailySummary.rolledOverTasks >= 2) {
      insights.add(Insight.rolloverWarning(
        id: 'insight_rollover_${now.millisecondsSinceEpoch}',
        rolloverCount: 2,
        taskCount: dailySummary.rolledOverTasks,
      ));
    }

    // 7. Top 3 달성 (기존 개선)
    if (dailySummary != null && dailySummary.top3CompletedCount > 0) {
      if (dailySummary.top3CompletedCount == 3) {
        insights.add(Insight(
          id: 'insight_top3_${now.millisecondsSinceEpoch}',
          type: InsightType.completionRate,
          priority: InsightPriority.high,
          title: 'Top 3 Task를 모두 완료했어요!',
          description: '오늘의 가장 중요한 일을 모두 해냈어요.',
          value: 3,
          unit: '개',
          iconCodePoint: 0xe838, // Icons.star
          isPositive: true,
          createdAt: now,
        ));
      } else {
        insights.add(Insight(
          id: 'insight_top3_${now.millisecondsSinceEpoch}',
          type: InsightType.completionRate,
          priority: InsightPriority.medium,
          title: 'Top 3 중 ${dailySummary.top3CompletedCount}개를 완료했어요',
          description: '${3 - dailySummary.top3CompletedCount}개가 남았어요. 마무리해볼까요?',
          value: dailySummary.top3CompletedCount.toDouble(),
          unit: '개',
          iconCodePoint: 0xe838, // Icons.star
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
          title: '오늘 생산성이 아주 높아요!',
          description: '${todayStats.score}점을 달성했어요. 대단해요!',
          value: todayStats.score.toDouble(),
          unit: '점',
          iconCodePoint: 0xe838, // Icons.star
          isPositive: true,
          createdAt: now,
        ));
      } else if (todayStats.score >= 50) {
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
          title: '이번 주 평균 생산성 ${avgScore.round()}점',
          description: avgScore >= 70
              ? '잘하고 있어요! 이 페이스를 유지해보세요.'
              : '조금씩 올려볼까요? 작은 개선이 모여 큰 변화가 돼요.',
          value: avgScore,
          unit: '점',
          iconCodePoint: 0xe1b1, // Icons.analytics_outlined
          isPositive: avgScore >= 50,
          createdAt: now,
        ));

        // 10. 가장 생산적인 요일
        final best = validStats.reduce(
          (a, b) => a.score >= b.score ? a : b,
        );
        const dayNames = ['', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];
        final dayName = dayNames[best.date.weekday];
        insights.add(Insight.bestDay(
          id: 'insight_bestday_${now.millisecondsSinceEpoch}',
          dayName: dayName,
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
              periodText: '주 전반부',
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
          title: '이번 달 평균 생산성 ${avgScore.round()}점',
          description: avgScore >= 70
              ? '높은 생산성을 유지하고 있어요!'
              : '꾸준히 기록하는 것 자체가 큰 발전이에요.',
          value: avgScore,
          unit: '점',
          iconCodePoint: 0xe1b1, // Icons.analytics_outlined
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
          title: '${best.date.month}월 ${best.date.day}일이 가장 생산적이었어요',
          description: '${best.score}점을 달성했어요.',
          value: best.score.toDouble(),
          unit: '점',
          iconCodePoint: 0xe838, // Icons.star
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
