import 'package:dartz/dartz.dart' hide Task;

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

/// 모든 Task 조회 UseCase
class GetTasks implements UseCase<List<Task>, NoParams> {
  final TaskRepository repository;

  GetTasks(this.repository);

  @override
  Future<Either<Failure, List<Task>>> call(NoParams params) {
    return repository.getTasks();
  }
}

/// 상태별 Task 조회 UseCase
class GetTasksByStatus implements UseCase<List<Task>, TaskStatus> {
  final TaskRepository repository;

  GetTasksByStatus(this.repository);

  @override
  Future<Either<Failure, List<Task>>> call(TaskStatus status) {
    return repository.getTasksByStatus(status);
  }
}
