part of 'task_bloc.dart';

/// Task BLoC 이벤트
sealed class TaskEvent {
  const TaskEvent();
}

/// Task 목록 로드
class LoadTasks extends TaskEvent {
  const LoadTasks();
}

/// Task 목록 구독 시작
class WatchTasksStarted extends TaskEvent {
  const WatchTasksStarted();
}

/// Task 목록 업데이트 (내부용)
class TasksUpdated extends TaskEvent {
  final List<Task> tasks;
  const TasksUpdated(this.tasks);
}

/// Task 생성
class CreateTaskEvent extends TaskEvent {
  final String title;
  final String? note;
  final Duration estimatedDuration;
  final TaskPriority priority;
  final List<Tag> tags;

  const CreateTaskEvent({
    required this.title,
    this.note,
    this.estimatedDuration = const Duration(minutes: 30),
    this.priority = TaskPriority.medium,
    this.tags = const [],
  });
}

/// Task 수정
class UpdateTaskEvent extends TaskEvent {
  final Task task;
  const UpdateTaskEvent(this.task);
}

/// Task 삭제
class DeleteTaskEvent extends TaskEvent {
  final String taskId;
  const DeleteTaskEvent(this.taskId);
}

/// 필터 변경
class FilterChanged extends TaskEvent {
  final TaskStatus? status;
  const FilterChanged(this.status);
}

/// 검색
class SearchTasks extends TaskEvent {
  final String query;
  const SearchTasks(this.query);
}
