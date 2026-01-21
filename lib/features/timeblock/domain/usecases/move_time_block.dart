import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/time_block.dart';
import '../repositories/time_block_repository.dart';

/// TimeBlock 이동 UseCase (드래그 앤 드롭)
class MoveTimeBlock implements UseCase<TimeBlock, MoveTimeBlockParams> {
  final TimeBlockRepository repository;

  MoveTimeBlock(this.repository);

  @override
  Future<Either<Failure, TimeBlock>> call(MoveTimeBlockParams params) {
    return repository.moveTimeBlock(params.id, params.newStartTime);
  }
}

class MoveTimeBlockParams {
  final String id;
  final DateTime newStartTime;

  MoveTimeBlockParams({required this.id, required this.newStartTime});
}

/// TimeBlock 크기 조정 UseCase
class ResizeTimeBlock implements UseCase<TimeBlock, ResizeTimeBlockParams> {
  final TimeBlockRepository repository;

  ResizeTimeBlock(this.repository);

  @override
  Future<Either<Failure, TimeBlock>> call(ResizeTimeBlockParams params) {
    return repository.resizeTimeBlock(
        params.id, params.newStartTime, params.newEndTime);
  }
}

class ResizeTimeBlockParams {
  final String id;
  final DateTime newStartTime;
  final DateTime newEndTime;

  ResizeTimeBlockParams({
    required this.id,
    required this.newStartTime,
    required this.newEndTime,
  });
}
