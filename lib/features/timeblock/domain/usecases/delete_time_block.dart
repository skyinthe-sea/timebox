import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/time_block_repository.dart';

/// TimeBlock 삭제 UseCase
class DeleteTimeBlock implements UseCase<void, String> {
  final TimeBlockRepository repository;

  DeleteTimeBlock(this.repository);

  @override
  Future<Either<Failure, void>> call(String id) {
    return repository.deleteTimeBlock(id);
  }
}
