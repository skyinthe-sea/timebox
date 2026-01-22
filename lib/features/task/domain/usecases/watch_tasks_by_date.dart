import 'package:dartz/dartz.dart' hide Task;

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

/// 날짜별 Task 실시간 스트림 UseCase
class WatchTasksByDate implements StreamUseCase<List<Task>, DateTime> {
  final TaskRepository repository;

  WatchTasksByDate(this.repository);

  @override
  Stream<Either<Failure, List<Task>>> call(DateTime date) {
    return repository.watchTasksByDate(date);
  }
}
