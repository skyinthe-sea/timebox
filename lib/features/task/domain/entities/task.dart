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

  /// 태스크 대상 날짜
  final DateTime targetDate;

  /// 이월 횟수 (0 = 신규)
  final int rolloverCount;

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
    required this.targetDate,
    this.rolloverCount = 0,
  });

  /// 완료 여부
  bool get isCompleted => status == TaskStatus.done;

  /// 하위 할 일 완료율 (0.0 ~ 1.0)
  double get subtaskCompletionRate {
    if (subtasks.isEmpty) return 1.0;
    final completed = subtasks.where((s) => s.isCompleted).length;
    return completed / subtasks.length;
  }

  /// 이월 여부
  bool get isRollover => rolloverCount > 0;

  /// copyWith
  Task copyWith({
    String? id,
    String? title,
    String? note,
    Duration? estimatedDuration,
    List<Tag>? tags,
    TaskPriority? priority,
    TaskStatus? status,
    List<Subtask>? subtasks,
    DateTime? createdAt,
    DateTime? completedAt,
    DateTime? targetDate,
    int? rolloverCount,
    bool clearNote = false,
    bool clearCompletedAt = false,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      note: clearNote ? null : (note ?? this.note),
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      tags: tags ?? this.tags,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      subtasks: subtasks ?? this.subtasks,
      createdAt: createdAt ?? this.createdAt,
      completedAt: clearCompletedAt ? null : (completedAt ?? this.completedAt),
      targetDate: targetDate ?? this.targetDate,
      rolloverCount: rolloverCount ?? this.rolloverCount,
    );
  }
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
