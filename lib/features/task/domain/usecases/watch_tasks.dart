import 'package:dartz/dartz.dart' hide Task;

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

/// Task 실시간 스트림 UseCase
class WatchTasks implements StreamUseCase<List<Task>, NoParams> {
  final TaskRepository repository;

  WatchTasks(this.repository);

  @override
  Stream<Either<Failure, List<Task>>> call(NoParams params) {
    return repository.watchTasks();
  }
}
