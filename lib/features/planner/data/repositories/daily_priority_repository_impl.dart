import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/daily_priority.dart';
import '../../domain/repositories/daily_priority_repository.dart';
import '../datasources/daily_priority_local_datasource.dart';
import '../models/daily_priority_model.dart';

/// DailyPriority 저장소 구현
class DailyPriorityRepositoryImpl implements DailyPriorityRepository {
  final DailyPriorityLocalDataSource localDataSource;
  final Uuid _uuid = const Uuid();

  DailyPriorityRepositoryImpl({required this.localDataSource});

  /// 날짜 정규화 (시간을 자정으로)
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  @override
  Future<Either<Failure, DailyPriority?>> getDailyPriority(DateTime date) async {
    try {
      final model = await localDataSource.getDailyPriority(_normalizeDate(date));
      return Right(model?.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DailyPriority>> saveDailyPriority(
      DailyPriority dailyPriority) async {
    try {
      final model = DailyPriorityModel.fromEntity(dailyPriority);
      final savedModel = await localDataSource.saveDailyPriority(model);
      return Right(savedModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DailyPriority>> setTaskRank({
    required DateTime date,
    required int rank,
    String? taskId,
  }) async {
    try {
      final normalizedDate = _normalizeDate(date);
      var existing = await localDataSource.getDailyPriority(normalizedDate);
      final now = DateTime.now();

      DailyPriorityModel model;
      if (existing == null) {
        // 새로 생성
        model = DailyPriorityModel(
          id: _uuid.v4(),
          date: normalizedDate,
          rank1TaskId: rank == 1 ? taskId : null,
          rank2TaskId: rank == 2 ? taskId : null,
          rank3TaskId: rank == 3 ? taskId : null,
          createdAt: now,
          updatedAt: now,
        );
      } else {
        // 기존 업데이트
        model = existing.copyWith(
          rank1TaskId: rank == 1 ? taskId : existing.rank1TaskId,
          rank2TaskId: rank == 2 ? taskId : existing.rank2TaskId,
          rank3TaskId: rank == 3 ? taskId : existing.rank3TaskId,
          updatedAt: now,
        );
      }

      final savedModel = await localDataSource.saveDailyPriority(model);
      return Right(savedModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DailyPriority>> removeTaskFromRank({
    required DateTime date,
    required int rank,
  }) async {
    return setTaskRank(date: date, rank: rank, taskId: null);
  }

  @override
  Future<Either<Failure, List<DailyPriority>>> getDailyPrioritiesInRange({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final models = await localDataSource.getDailyPrioritiesInRange(
        startDate: _normalizeDate(startDate),
        endDate: _normalizeDate(endDate),
      );
      return Right(models.map((m) => m.toEntity()).toList());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, DailyPriority?>> watchDailyPriority(DateTime date) {
    return localDataSource
        .watchDailyPriority(_normalizeDate(date))
        .map((model) => Right<Failure, DailyPriority?>(model?.toEntity()))
        .handleError(
          (error) => Left<Failure, DailyPriority?>(
            error is CacheException
                ? CacheFailure(message: error.message)
                : UnknownFailure(message: error.toString()),
          ),
        );
  }

  @override
  Future<Either<Failure, void>> deleteDailyPriority(DateTime date) async {
    try {
      await localDataSource.deleteDailyPriority(_normalizeDate(date));
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
