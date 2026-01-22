import 'package:dartz/dartz.dart' hide Task;

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

/// Task 이월 UseCase (rolloverCount 증가 및 대상 날짜 변경)
class RolloverTask implements UseCase<Task, RolloverTaskParams> {
  final TaskRepository repository;

  RolloverTask(this.repository);

  @override
  Future<Either<Failure, Task>> call(RolloverTaskParams params) {
    return repository.rolloverTask(params.taskId, params.toDate);
  }
}

class RolloverTaskParams {
  final String taskId;
  final DateTime toDate;

  const RolloverTaskParams({
    required this.taskId,
    required this.toDate,
  });
}
