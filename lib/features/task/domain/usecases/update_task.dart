import 'package:dartz/dartz.dart' hide Task;

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

/// Task 수정 UseCase
class UpdateTask implements UseCase<Task, Task> {
  final TaskRepository repository;

  UpdateTask(this.repository);

  @override
  Future<Either<Failure, Task>> call(Task task) {
    return repository.updateTask(task);
  }
}

/// Task 상태 변경 UseCase
class UpdateTaskStatus implements UseCase<Task, UpdateTaskStatusParams> {
  final TaskRepository repository;

  UpdateTaskStatus(this.repository);

  @override
  Future<Either<Failure, Task>> call(UpdateTaskStatusParams params) {
    return repository.updateTaskStatus(params.id, params.status);
  }
}

class UpdateTaskStatusParams {
  final String id;
  final TaskStatus status;

  UpdateTaskStatusParams({required this.id, required this.status});
}
