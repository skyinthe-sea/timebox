import 'package:dartz/dartz.dart' hide Task;

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

/// Task 생성 UseCase
class CreateTask implements UseCase<Task, Task> {
  final TaskRepository repository;

  CreateTask(this.repository);

  @override
  Future<Either<Failure, Task>> call(Task task) {
    return repository.createTask(task);
  }
}
