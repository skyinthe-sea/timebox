import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/daily_priority.dart';
import '../repositories/daily_priority_repository.dart';

/// 특정 날짜의 DailyPriority 조회 UseCase
class GetDailyPriority implements UseCase<DailyPriority?, DateTime> {
  final DailyPriorityRepository repository;

  GetDailyPriority(this.repository);

  @override
  Future<Either<Failure, DailyPriority?>> call(DateTime date) {
    return repository.getDailyPriority(date);
  }
}
