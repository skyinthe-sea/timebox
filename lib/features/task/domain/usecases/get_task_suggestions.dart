import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/task_suggestion.dart';
import '../repositories/task_repository.dart';

/// Task 제안 조회 UseCase
class GetTaskSuggestions
    implements UseCase<List<TaskSuggestion>, GetTaskSuggestionsParams> {
  final TaskRepository repository;

  GetTaskSuggestions(this.repository);

  @override
  Future<Either<Failure, List<TaskSuggestion>>> call(
    GetTaskSuggestionsParams params,
  ) {
    return repository.getTaskSuggestions(params.query, params.currentTime);
  }
}

class GetTaskSuggestionsParams {
  final String query;
  final DateTime currentTime;

  const GetTaskSuggestionsParams({
    required this.query,
    required this.currentTime,
  });
}
