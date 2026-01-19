import 'subtask.dart';
import 'tag.dart';

/// Task 엔티티
///
/// 인박스의 할 일 항목을 나타내는 핵심 도메인 객체
///
/// 기능:
/// - 브레인 덤프로 빠르게 추가
/// - 예상 소요 시간 설정
/// - 태그 및 우선순위 지정
/// - 하위 할 일 관리
class Task {
  /// 고유 식별자
  final String id;

  /// 할 일 제목
  final String title;

  /// 메모 (선택)
  final String? note;

  /// 예상 소요 시간
  final Duration estimatedDuration;

  /// 태그 목록
  final List<Tag> tags;

  /// 우선순위
  final TaskPriority priority;

  /// 상태
  final TaskStatus status;

  /// 하위 할 일 목록
  final List<Subtask> subtasks;

  /// 생성 시간
  final DateTime createdAt;

  /// 완료 시간 (선택)
  final DateTime? completedAt;

  const Task({
    required this.id,
    required this.title,
    this.note,
    required this.estimatedDuration,
    this.tags = const [],
    this.priority = TaskPriority.medium,
    this.status = TaskStatus.todo,
    this.subtasks = const [],
    required this.createdAt,
    this.completedAt,
  });

  /// 완료 여부
  bool get isCompleted => status == TaskStatus.done;

  /// 하위 할 일 완료율 (0.0 ~ 1.0)
  double get subtaskCompletionRate {
    if (subtasks.isEmpty) return 1.0;
    final completed = subtasks.where((s) => s.isCompleted).length;
    return completed / subtasks.length;
  }

  // TODO: copyWith, props (Equatable), toJson/fromJson 구현
}

/// 할 일 우선순위
enum TaskPriority {
  high,
  medium,
  low,
}

/// 할 일 상태
enum TaskStatus {
  /// 할 일 (미완료)
  todo,

  /// 완료됨
  done,

  /// 보관됨
  archived,
}
