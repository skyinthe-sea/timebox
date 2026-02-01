/// Task Pipeline 통계 엔티티
///
/// 브레인덤프 → 스케줄 → 완료 흐름 데이터
class TaskPipelineStats {
  /// 브레인덤프 전체 Task 수
  final int totalTasks;

  /// TimeBlock에 배치된 Task 수
  final int scheduledTasks;

  /// 완료된 Task 수
  final int completedTasks;

  /// 이월된 Task 수
  final int rolledOverTasks;

  const TaskPipelineStats({
    required this.totalTasks,
    required this.scheduledTasks,
    required this.completedTasks,
    required this.rolledOverTasks,
  });

  /// 스케줄링 비율 (%)
  double get schedulingRate =>
      totalTasks > 0 ? scheduledTasks / totalTasks * 100 : 0.0;

  /// 완료 비율 (%)
  double get completionRate =>
      totalTasks > 0 ? completedTasks / totalTasks * 100 : 0.0;

  /// 빈 통계
  static const empty = TaskPipelineStats(
    totalTasks: 0,
    scheduledTasks: 0,
    completedTasks: 0,
    rolledOverTasks: 0,
  );
}
