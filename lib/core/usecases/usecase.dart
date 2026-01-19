import 'package:dartz/dartz.dart';
import '../error/failures.dart';

/// UseCase 베이스 클래스
///
/// 모든 UseCase가 구현해야 하는 인터페이스
/// - T: 반환 타입
/// - Params: 파라미터 타입
///
/// 예시:
/// ```dart
/// class GetTasks implements UseCase<List<Task>, NoParams> {
///   @override
///   Future<Either<Failure, List<Task>>> call(NoParams params) async {
///     return await repository.getTasks();
///   }
/// }
/// ```
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// 파라미터가 없는 경우 사용
class NoParams {
  const NoParams();
}

/// 스트림을 반환하는 UseCase
///
/// 실시간 데이터 구독이 필요한 경우 사용
abstract class StreamUseCase<T, Params> {
  Stream<Either<Failure, T>> call(Params params);
}
