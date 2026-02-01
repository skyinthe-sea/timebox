/// Task 완료 랭킹 엔티티
///
/// 특정 기간 내 가장 많이 완료하거나 실패한 Task 순위
class TaskCompletionRanking {
  /// Task 제목 (정규화)
  final String title;

  /// 총 생성 횟수
  final int totalCount;

  /// 완료 횟수
  final int completedCount;

  /// 완료율 (0.0 ~ 1.0)
  final double completionRate;

  const TaskCompletionRanking({
    required this.title,
    required this.totalCount,
    required this.completedCount,
    required this.completionRate,
  });
}
