import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/daily_priority.dart';
import '../repositories/daily_priority_repository.dart';

/// 특정 순위에서 Task 제거 UseCase
class RemoveTaskFromRank implements UseCase<DailyPriority, RemoveTaskFromRankParams> {
  final DailyPriorityRepository repository;

  RemoveTaskFromRank(this.repository);

  @override
  Future<Either<Failure, DailyPriority>> call(RemoveTaskFromRankParams params) {
    return repository.removeTaskFromRank(
      date: params.date,
      rank: params.rank,
    );
  }
}

/// RemoveTaskFromRank UseCase 파라미터
class RemoveTaskFromRankParams {
  final DateTime date;
  final int rank;

  const RemoveTaskFromRankParams({
    required this.date,
    required this.rank,
  });
}
