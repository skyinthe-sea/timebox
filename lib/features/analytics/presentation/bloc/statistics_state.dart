import 'package:equatable/equatable.dart';

import '../../domain/entities/daily_stats_summary.dart';
import '../../domain/entities/hourly_productivity.dart';
import '../../domain/entities/insight.dart';
import '../../domain/entities/productivity_stats.dart';
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

  /// 에러 메시지
  final String? errorMessage;

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
    this.errorMessage,
  });

  /// 초기 상태
  factory StatisticsState.initial() {
    return StatisticsState(
      selectedDate: DateTime.now(),
    );
  }

  /// 생산성 점수 변화 (어제 대비)
  int? get scoreChange {
    if (todayStats == null || yesterdayStats == null) return null;
    return todayStats!.score - yesterdayStats!.score;
  }

  /// 오늘 완료한 TimeBlock 수
  int get completedTasks => todayStats?.completedTimeBlocks ?? 0;

  /// 오늘 실패(미완료)한 TimeBlock 수
  int get skippedTasks => todayStats?.skippedTimeBlocks ?? 0;

  /// 오늘 총 집중 시간 (분)
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
    String? errorMessage,
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
      errorMessage: errorMessage ?? this.errorMessage,
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
        errorMessage,
      ];
}
