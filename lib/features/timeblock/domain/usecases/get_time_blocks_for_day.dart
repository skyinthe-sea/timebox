import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/time_block.dart';
import '../repositories/time_block_repository.dart';

/// 특정 날짜의 TimeBlock 조회 UseCase
class GetTimeBlocksForDay implements UseCase<List<TimeBlock>, DateTime> {
  final TimeBlockRepository repository;

  GetTimeBlocksForDay(this.repository);

  @override
  Future<Either<Failure, List<TimeBlock>>> call(DateTime date) {
    return repository.getTimeBlocksForDay(date);
  }
}

/// 특정 날짜의 TimeBlock 실시간 스트림 UseCase
class WatchTimeBlocksForDay implements StreamUseCase<List<TimeBlock>, DateTime> {
  final TimeBlockRepository repository;

  WatchTimeBlocksForDay(this.repository);

  @override
  Stream<Either<Failure, List<TimeBlock>>> call(DateTime date) {
    return repository.watchTimeBlocksForDay(date);
  }
}
