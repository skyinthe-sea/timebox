import 'package:dartz/dartz.dart' hide Task;

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

/// Task를 다른 날짜로 복제 UseCase (내일도 하기)
class CopyTaskToDate implements UseCase<Task, CopyTaskToDateParams> {
  final TaskRepository repository;

  CopyTaskToDate(this.repository);

  @override
  Future<Either<Failure, Task>> call(CopyTaskToDateParams params) {
    return repository.copyTaskToDate(params.taskId, params.targetDate);
  }
}

class CopyTaskToDateParams {
  final String taskId;
  final DateTime targetDate;

  const CopyTaskToDateParams({
    required this.taskId,
    required this.targetDate,
  });
}
