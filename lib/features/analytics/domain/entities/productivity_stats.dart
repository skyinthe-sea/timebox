/// ProductivityStats 엔티티
///
/// 생산성 통계를 나타내는 도메인 객체
///
/// 일간/주간 생산성 점수 및 통계 데이터
class ProductivityStats {
  /// 날짜 (일간 통계의 경우)
  final DateTime date;

  /// 생산성 점수 (0 ~ 100)
  final int score;

  /// 완료한 Task 수
  final int completedTasks;

  /// 전체 계획한 Task 수
  final int totalPlannedTasks;

  /// 완료한 TimeBlock 수
  final int completedTimeBlocks;

  /// 실패(건너뛴) TimeBlock 수
  final int skippedTimeBlocks;

  /// 전체 계획한 TimeBlock 수
  final int totalPlannedTimeBlocks;

  /// 계획 대비 실행률 (%)
  final double executionRate;

  /// 총 계획 시간
  final Duration totalPlannedTime;

  /// 총 실제 작업 시간
  final Duration totalActualTime;

  /// 집중 시간 (Focus Mode에서 보낸 시간)
  final Duration focusTime;

  /// 평균 시간 오차 (실제 - 계획)
  final Duration averageTimeDifference;

  const ProductivityStats({
    required this.date,
    required this.score,
    required this.completedTasks,
    required this.totalPlannedTasks,
    required this.completedTimeBlocks,
    this.skippedTimeBlocks = 0,
    required this.totalPlannedTimeBlocks,
    required this.executionRate,
    required this.totalPlannedTime,
    required this.totalActualTime,
    required this.focusTime,
    required this.averageTimeDifference,
  });

  /// Task 완료율 (%)
  double get taskCompletionRate {
    if (totalPlannedTasks == 0) return 100.0;
    return (completedTasks / totalPlannedTasks) * 100;
  }

  /// TimeBlock 완료율 (%)
  double get timeBlockCompletionRate {
    if (totalPlannedTimeBlocks == 0) return 100.0;
    return (completedTimeBlocks / totalPlannedTimeBlocks) * 100;
  }

  /// 시간 정확도 (100% - 오차율)
  double get timeAccuracy {
    if (totalPlannedTime.inMinutes == 0) return 100.0;
    final diffRatio = averageTimeDifference.inMinutes.abs() /
        totalPlannedTime.inMinutes;
    return (1 - diffRatio).clamp(0.0, 1.0) * 100;
  }

  // TODO: copyWith, props (Equatable), toJson/fromJson 구현
}
