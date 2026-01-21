import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/daily_priority.dart';
import '../repositories/daily_priority_repository.dart';

/// DailyPriority 실시간 스트림 UseCase
class WatchDailyPriority implements StreamUseCase<DailyPriority?, DateTime> {
  final DailyPriorityRepository repository;

  WatchDailyPriority(this.repository);

  @override
  Stream<Either<Failure, DailyPriority?>> call(DateTime date) {
    return repository.watchDailyPriority(date);
  }
}
