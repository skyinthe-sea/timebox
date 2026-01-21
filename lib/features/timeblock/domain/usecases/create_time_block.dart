import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/time_block.dart';
import '../repositories/time_block_repository.dart';

/// TimeBlock 생성 UseCase
class CreateTimeBlock implements UseCase<TimeBlock, TimeBlock> {
  final TimeBlockRepository repository;

  CreateTimeBlock(this.repository);

  @override
  Future<Either<Failure, TimeBlock>> call(TimeBlock timeBlock) {
    return repository.createTimeBlock(timeBlock);
  }
}
