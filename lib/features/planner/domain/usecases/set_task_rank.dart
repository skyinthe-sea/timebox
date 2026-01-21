import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/daily_priority.dart';
import '../repositories/daily_priority_repository.dart';

/// 특정 순위에 Task 설정 UseCase
class SetTaskRank implements UseCase<DailyPriority, SetTaskRankParams> {
  final DailyPriorityRepository repository;

  SetTaskRank(this.repository);

  @override
  Future<Either<Failure, DailyPriority>> call(SetTaskRankParams params) {
    return repository.setTaskRank(
      date: params.date,
      rank: params.rank,
      taskId: params.taskId,
    );
  }
}

/// SetTaskRank UseCase 파라미터
class SetTaskRankParams {
  final DateTime date;
  final int rank;
  final String? taskId;

  const SetTaskRankParams({
    required this.date,
    required this.rank,
    this.taskId,
  });
}
