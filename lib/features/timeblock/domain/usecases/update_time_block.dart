import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/time_block.dart';
import '../repositories/time_block_repository.dart';

/// TimeBlock 수정 UseCase
class UpdateTimeBlock implements UseCase<TimeBlock, TimeBlock> {
  final TimeBlockRepository repository;

  UpdateTimeBlock(this.repository);

  @override
  Future<Either<Failure, TimeBlock>> call(TimeBlock timeBlock) {
    return repository.updateTimeBlock(timeBlock);
  }
}

/// TimeBlock 상태 변경 UseCase
class UpdateTimeBlockStatus implements UseCase<TimeBlock, UpdateTimeBlockStatusParams> {
  final TimeBlockRepository repository;

  UpdateTimeBlockStatus(this.repository);

  @override
  Future<Either<Failure, TimeBlock>> call(UpdateTimeBlockStatusParams params) {
    return repository.updateTimeBlockStatus(params.id, params.status);
  }
}

class UpdateTimeBlockStatusParams {
  final String id;
  final TimeBlockStatus status;

  UpdateTimeBlockStatusParams({required this.id, required this.status});
}
