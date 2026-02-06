import 'package:equatable/equatable.dart';

import '../../domain/entities/daily_stats_summary.dart';
import '../../domain/entities/hourly_productivity.dart';
import '../../domain/entities/insight.dart';
import '../../domain/entities/priority_breakdown_stats.dart';
import '../../domain/entities/productivity_stats.dart';
import '../../domain/entities/task_completion_ranking.dart';
import '../../domain/entities/task_pipeline_stats.dart';
import '../../domain/entities/time_comparison.dart';
import 'statistics_event.dart';

/// 통계 로딩 상태
enum StatisticsStatus {
  initial,
  loading,
  loaded,
  error,
}

/// Statistics BLoC 상태
class StatisticsState extends Equatable {
  /// 현재 기간 (일간/주간/월간)
  final StatsPeriod currentPeriod;

  /// 선택된 날짜
  final DateTime selectedDate;

  /// 로딩 상태
  final StatisticsStatus status;

  /// 오늘의 통계
  final ProductivityStats? todayStats;

  /// 어제의 통계 (비교용)
  final ProductivityStats? yesterdayStats;

  /// 기간별 통계 목록
  final List<ProductivityStats> periodStats;

  /// 태그별 통계
  final List<TagTimeComparison> tagStats;

  /// 시간대별 생산성 (히트맵)
  final ProductivityHeatmapData? hourlyProductivity;

  /// 인사이트 목록
  final List<Insight> insights;

  /// 일간 요약 (캐시된 데이터)
  final DailyStatsSummary? dailySummary;

  /// Task Pipeline 통계
  final TaskPipelineStats? pipelineStats;

  /// 우선순위별 성과 통계
  final PriorityBreakdownStats? priorityBreakdown;

  /// 계획 vs 실제 시간 비교 데이터
  final List<TimeComparison> timeComparisons;

  /// Top 5 성공 Task 랭킹
  final List<TaskCompletionRanking> topSuccessTasks;

  /// Top 5 실패 Task 랭킹
  final List<TaskCompletionRanking> topFailureTasks;

  /// 기간 내 일별 요약 목록 (Top 3 통계용)
  final List<DailyStatsSummary> periodSummaries;

  /// 에러 메시지
  final String? errorMessage;

  // === 기간별 캐시 (탭 전환 시 즉시 표시) ===
  /// 주간 데이터 캐시
  final PeriodCache? weeklyCache;

  /// 월간 데이터 캐시
  final PeriodCache? monthlyCache;

  const StatisticsState({
    this.currentPeriod = StatsPeriod.daily,
    required this.selectedDate,
    this.status = StatisticsStatus.initial,
    this.todayStats,
    this.yesterdayStats,
    this.periodStats = const [],
    this.tagStats = const [],
    this.hourlyProductivity,
    this.insights = const [],
    this.dailySummary,
    this.pipelineStats,
    this.priorityBreakdown,
    this.timeComparisons = const [],
    this.topSuccessTasks = const [],
    this.topFailureTasks = const [],
    this.periodSummaries = const [],
    this.errorMessage,
    this.weeklyCache,
    this.monthlyCache,
  });

  /// 초기 상태
  factory StatisticsState.initial() {
    return StatisticsState(
      selectedDate: DateTime.now(),
    );
  }

  /// 현재 기간에 맞는 표시용 통계
  /// daily: 오늘 통계, weekly/monthly: 기간 집계
  ProductivityStats? get displayStats {
    if (currentPeriod == StatsPeriod.daily || periodStats.isEmpty) {
      return todayStats;
    }
    // 데이터가 있는 날만 집계
    final validStats = periodStats.where((s) =>
        s.score > 0 ||
        s.totalPlannedTasks > 0 ||
        s.totalPlannedTimeBlocks > 0).toList();
    if (validStats.isEmpty) return todayStats;

    final avgScore =
        validStats.fold<int>(0, (sum, s) => sum + s.score) ~/ validStats.length;
    final totalCompleted =
        validStats.fold<int>(0, (sum, s) => sum + s.completedTasks);
    final totalPlanned =
        validStats.fold<int>(0, (sum, s) => sum + s.totalPlannedTasks);
    final totalCompletedBlocks =
        validStats.fold<int>(0, (sum, s) => sum + s.completedTimeBlocks);
    final totalSkippedBlocks =
        validStats.fold<int>(0, (sum, s) => sum + s.skippedTimeBlocks);
    final totalPlannedBlocks =
        validStats.fold<int>(0, (sum, s) => sum + s.totalPlannedTimeBlocks);
    final totalPlannedTime = validStats.fold<Duration>(
        Duration.zero, (sum, s) => sum + s.totalPlannedTime);
    final totalActualTime = validStats.fold<Duration>(
        Duration.zero, (sum, s) => sum + s.totalActualTime);
    final totalFocusTime = validStats.fold<Duration>(
        Duration.zero, (sum, s) => sum + s.focusTime);
    final executionRate = totalPlannedBlocks > 0
        ? (totalCompletedBlocks / totalPlannedBlocks) * 100
        : 0.0;

    return ProductivityStats(
      date: selectedDate,
      score: avgScore,
      completedTasks: totalCompleted,
      totalPlannedTasks: totalPlanned,
      completedTimeBlocks: totalCompletedBlocks,
      skippedTimeBlocks: totalSkippedBlocks,
      totalPlannedTimeBlocks: totalPlannedBlocks,
      executionRate: executionRate,
      totalPlannedTime: totalPlannedTime,
      totalActualTime: totalActualTime,
      focusTime: totalFocusTime,
      averageTimeDifference: totalActualTime - totalPlannedTime,
    );
  }

  /// 생산성 점수 변화 (일간: 어제 대비, 주간/월간: 표시 안 함)
  int? get scoreChange {
    if (currentPeriod != StatsPeriod.daily) return null;
    if (todayStats == null || yesterdayStats == null) return null;
    return todayStats!.score - yesterdayStats!.score;
  }

  /// 완료한 Task 수
  int get completedTasks => dailySummary?.completedTasks ?? todayStats?.completedTasks ?? 0;

  /// 미완료 Task 수
  int get skippedTasks {
    final total = dailySummary?.totalPlannedTasks ?? todayStats?.totalPlannedTasks ?? 0;
    final completed = dailySummary?.completedTasks ?? todayStats?.completedTasks ?? 0;
    return (total - completed).clamp(0, total);
  }

  /// 총 Task 수
  int get totalTasks => dailySummary?.totalPlannedTasks ?? todayStats?.totalPlannedTasks ?? 0;

  /// 총 집중 시간 (분)
  int get focusMinutes => todayStats?.focusTime.inMinutes ?? 0;

  /// 시간 절약/초과 (분)
  int get timeDifferenceMinutes {
    if (todayStats == null) return 0;
    return todayStats!.totalPlannedTime.inMinutes -
        todayStats!.totalActualTime.inMinutes;
  }

  /// 로딩 중 여부
  bool get isLoading => status == StatisticsStatus.loading;

  /// 에러 여부
  bool get hasError => status == StatisticsStatus.error;

  /// 데이터 있음 여부
  bool get hasData => todayStats != null;

  StatisticsState copyWith({
    StatsPeriod? currentPeriod,
    DateTime? selectedDate,
    StatisticsStatus? status,
    ProductivityStats? todayStats,
    ProductivityStats? yesterdayStats,
    List<ProductivityStats>? periodStats,
    List<TagTimeComparison>? tagStats,
    ProductivityHeatmapData? hourlyProductivity,
    List<Insight>? insights,
    DailyStatsSummary? dailySummary,
    TaskPipelineStats? pipelineStats,
    PriorityBreakdownStats? priorityBreakdown,
    List<TimeComparison>? timeComparisons,
    List<TaskCompletionRanking>? topSuccessTasks,
    List<TaskCompletionRanking>? topFailureTasks,
    List<DailyStatsSummary>? periodSummaries,
    String? errorMessage,
    PeriodCache? weeklyCache,
    PeriodCache? monthlyCache,
  }) {
    return StatisticsState(
      currentPeriod: currentPeriod ?? this.currentPeriod,
      selectedDate: selectedDate ?? this.selectedDate,
      status: status ?? this.status,
      todayStats: todayStats ?? this.todayStats,
      yesterdayStats: yesterdayStats ?? this.yesterdayStats,
      periodStats: periodStats ?? this.periodStats,
      tagStats: tagStats ?? this.tagStats,
      hourlyProductivity: hourlyProductivity ?? this.hourlyProductivity,
      insights: insights ?? this.insights,
      dailySummary: dailySummary ?? this.dailySummary,
      pipelineStats: pipelineStats ?? this.pipelineStats,
      priorityBreakdown: priorityBreakdown ?? this.priorityBreakdown,
      timeComparisons: timeComparisons ?? this.timeComparisons,
      topSuccessTasks: topSuccessTasks ?? this.topSuccessTasks,
      topFailureTasks: topFailureTasks ?? this.topFailureTasks,
      periodSummaries: periodSummaries ?? this.periodSummaries,
      errorMessage: errorMessage ?? this.errorMessage,
      weeklyCache: weeklyCache ?? this.weeklyCache,
      monthlyCache: monthlyCache ?? this.monthlyCache,
    );
  }

  @override
  List<Object?> get props => [
        currentPeriod,
        selectedDate,
        status,
        todayStats,
        yesterdayStats,
        periodStats,
        tagStats,
        hourlyProductivity,
        insights,
        dailySummary,
        pipelineStats,
        priorityBreakdown,
        timeComparisons,
        topSuccessTasks,
        topFailureTasks,
        periodSummaries,
        errorMessage,
        weeklyCache,
        monthlyCache,
      ];
}

/// 기간별 캐시 데이터
class PeriodCache extends Equatable {
  final List<ProductivityStats> periodStats;
  final List<TagTimeComparison> tagStats;
  final TaskPipelineStats? pipelineStats;
  final List<DailyStatsSummary> periodSummaries;
  final List<TimeComparison> timeComparisons;
  final List<TaskCompletionRanking> topSuccessTasks;
  final List<TaskCompletionRanking> topFailureTasks;

  const PeriodCache({
    required this.periodStats,
    required this.tagStats,
    this.pipelineStats,
    required this.periodSummaries,
    required this.timeComparisons,
    required this.topSuccessTasks,
    required this.topFailureTasks,
  });

  @override
  List<Object?> get props => [
        periodStats,
        tagStats,
        pipelineStats,
        periodSummaries,
        timeComparisons,
        topSuccessTasks,
        topFailureTasks,
      ];
}
