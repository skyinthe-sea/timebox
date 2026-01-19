/// Subtask 엔티티
///
/// Task의 하위 할 일 (체크리스트 항목)
///
/// 큰 작업을 작은 단위로 분해하여 관리
class Subtask {
  /// 고유 식별자
  final String id;

  /// 상위 Task ID
  final String taskId;

  /// 하위 할 일 제목
  final String title;

  /// 완료 여부
  final bool isCompleted;

  /// 생성 순서 (정렬용)
  final int order;

  const Subtask({
    required this.id,
    required this.taskId,
    required this.title,
    this.isCompleted = false,
    this.order = 0,
  });

  // TODO: copyWith, props (Equatable), toJson/fromJson 구현
}
