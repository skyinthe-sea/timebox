import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/tag.dart';
import '../../domain/usecases/create_task.dart';
import '../../domain/usecases/delete_task.dart';
import '../../domain/usecases/update_task.dart';
import '../../domain/usecases/watch_tasks.dart';

part 'task_event.dart';
part 'task_state.dart';

/// Task BLoC
///
/// 인박스의 할 일 목록 관리
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final WatchTasks watchTasks;
  final CreateTask createTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;
  final UpdateTaskStatus updateTaskStatus;

  StreamSubscription? _tasksSubscription;
  final _uuid = const Uuid();

  TaskBloc({
    required this.watchTasks,
    required this.createTask,
    required this.updateTask,
    required this.deleteTask,
    required this.updateTaskStatus,
  }) : super(const TaskState()) {
    on<WatchTasksStarted>(_onWatchTasksStarted);
    on<TasksUpdated>(_onTasksUpdated);
    on<LoadTasks>(_onLoadTasks);
    on<CreateTaskEvent>(_onCreateTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<ToggleTaskStatus>(_onToggleTaskStatus);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<FilterChanged>(_onFilterChanged);
    on<SearchTasks>(_onSearchTasks);
  }

  Future<void> _onWatchTasksStarted(
    WatchTasksStarted event,
    Emitter<TaskState> emit,
  ) async {
    emit(state.copyWith(status: TaskStateStatus.loading));

    await _tasksSubscription?.cancel();
    _tasksSubscription = watchTasks(NoParams()).listen(
      (result) {
        result.fold(
          (failure) => add(TasksUpdated(const [])),
          (tasks) => add(TasksUpdated(tasks)),
        );
      },
    );
  }

  void _onTasksUpdated(
    TasksUpdated event,
    Emitter<TaskState> emit,
  ) {
    emit(state.copyWith(
      status: TaskStateStatus.success,
      tasks: event.tasks,
      clearError: true,
    ));
  }

  Future<void> _onLoadTasks(
    LoadTasks event,
    Emitter<TaskState> emit,
  ) async {
    // WatchTasks가 이미 실행 중이면 스킵
    if (_tasksSubscription != null) return;
    add(const WatchTasksStarted());
  }

  Future<void> _onCreateTask(
    CreateTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    final task = Task(
      id: _uuid.v4(),
      title: event.title,
      note: event.note,
      estimatedDuration: event.estimatedDuration,
      priority: event.priority,
      tags: event.tags,
      status: TaskStatus.todo,
      subtasks: const [],
      createdAt: DateTime.now(),
      targetDate: DateTime.now(),
    );

    final result = await createTask(task);
    result.fold(
      (failure) => emit(state.copyWith(
        status: TaskStateStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => {}, // watchTasks가 자동으로 업데이트
    );
  }

  Future<void> _onUpdateTask(
    UpdateTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    final result = await updateTask(event.task);
    result.fold(
      (failure) => emit(state.copyWith(
        status: TaskStateStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => {},
    );
  }

  Future<void> _onToggleTaskStatus(
    ToggleTaskStatus event,
    Emitter<TaskState> emit,
  ) async {
    final task = state.tasks.firstWhere(
      (t) => t.id == event.taskId,
      orElse: () => throw Exception('Task not found'),
    );

    final newStatus =
        task.status == TaskStatus.done ? TaskStatus.todo : TaskStatus.done;

    final result = await updateTaskStatus(
      UpdateTaskStatusParams(id: event.taskId, status: newStatus),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: TaskStateStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => {},
    );
  }

  Future<void> _onDeleteTask(
    DeleteTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    final result = await deleteTask(event.taskId);
    result.fold(
      (failure) => emit(state.copyWith(
        status: TaskStateStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => {},
    );
  }

  void _onFilterChanged(
    FilterChanged event,
    Emitter<TaskState> emit,
  ) {
    emit(state.copyWith(
      filter: event.status,
      clearFilter: event.status == null,
    ));
  }

  void _onSearchTasks(
    SearchTasks event,
    Emitter<TaskState> emit,
  ) {
    emit(state.copyWith(
      searchQuery: event.query,
      clearSearch: event.query.isEmpty,
    ));
  }

  @override
  Future<void> close() {
    _tasksSubscription?.cancel();
    return super.close();
  }
}
