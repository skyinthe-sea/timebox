part of 'task_bloc.dart';

/// Task BLoC 상태
enum TaskStateStatus { initial, loading, success, failure }

class TaskState extends Equatable {
  final TaskStateStatus status;
  final List<Task> tasks;
  final TaskStatus? filter;
  final String? searchQuery;
  final String? errorMessage;

  const TaskState({
    this.status = TaskStateStatus.initial,
    this.tasks = const [],
    this.filter,
    this.searchQuery,
    this.errorMessage,
  });

  /// 필터링된 Task 목록
  List<Task> get filteredTasks {
    var result = tasks;

    // 상태 필터
    if (filter != null) {
      result = result.where((t) => t.status == filter).toList();
    }

    // 검색 필터
    if (searchQuery != null && searchQuery!.isNotEmpty) {
      final query = searchQuery!.toLowerCase();
      result = result
          .where((t) =>
              t.title.toLowerCase().contains(query) ||
              (t.note?.toLowerCase().contains(query) ?? false))
          .toList();
    }

    return result;
  }

  /// 할 일 개수 (미완료)
  int get todoCount => tasks.where((t) => t.status == TaskStatus.todo).length;

  /// 완료 개수
  int get doneCount => tasks.where((t) => t.status == TaskStatus.done).length;

  TaskState copyWith({
    TaskStateStatus? status,
    List<Task>? tasks,
    TaskStatus? filter,
    String? searchQuery,
    String? errorMessage,
    bool clearFilter = false,
    bool clearSearch = false,
    bool clearError = false,
  }) {
    return TaskState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      filter: clearFilter ? null : (filter ?? this.filter),
      searchQuery: clearSearch ? null : (searchQuery ?? this.searchQuery),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props =>
      [status, tasks, filter, searchQuery, errorMessage];
}
