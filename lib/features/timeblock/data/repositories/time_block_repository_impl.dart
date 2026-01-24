import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../analytics/data/datasources/analytics_local_datasource.dart';
import '../../domain/entities/time_block.dart';
import '../../domain/repositories/time_block_repository.dart';
import '../datasources/time_block_local_datasource.dart';
import '../models/time_block_model.dart';

/// TimeBlock Repository 구현
class TimeBlockRepositoryImpl implements TimeBlockRepository {
  final TimeBlockLocalDataSource localDataSource;
  final AnalyticsLocalDataSource? analyticsDataSource;

  TimeBlockRepositoryImpl({
    required this.localDataSource,
    this.analyticsDataSource,
  });

  @override
  Future<Either<Failure, List<TimeBlock>>> getTimeBlocksForDay(
      DateTime date) async {
    try {
      final models = await localDataSource.getTimeBlocksForDay(date);
      final timeBlocks = models.map((m) => m.toEntity()).toList();
      return Right(timeBlocks);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TimeBlock>>> getTimeBlocksForRange(
      DateTime start, DateTime end) async {
    try {
      final models = await localDataSource.getTimeBlocksForRange(start, end);
      final timeBlocks = models.map((m) => m.toEntity()).toList();
      return Right(timeBlocks);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TimeBlock>> getTimeBlockById(String id) async {
    try {
      final model = await localDataSource.getTimeBlockById(id);
      if (model == null) {
        return Left(CacheFailure(message: 'TimeBlock not found'));
      }
      return Right(model.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TimeBlock>> createTimeBlock(
      TimeBlock timeBlock) async {
    try {
      final model = TimeBlockModel.fromEntity(timeBlock);
      final savedModel = await localDataSource.saveTimeBlock(model);
      return Right(savedModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TimeBlock>> updateTimeBlock(
      TimeBlock timeBlock) async {
    try {
      final model = TimeBlockModel.fromEntity(timeBlock);
      final savedModel = await localDataSource.saveTimeBlock(model);
      return Right(savedModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTimeBlock(String id) async {
    try {
      // 삭제 전 날짜 정보 먼저 조회
      final model = await localDataSource.getTimeBlockById(id);

      await localDataSource.deleteTimeBlock(id);

      // 통계 캐시 무효화
      if (model != null && analyticsDataSource != null) {
        final date = DateTime(
          model.startTime.year,
          model.startTime.month,
          model.startTime.day,
        );
        await analyticsDataSource!.deleteDailyStatsSummary(date);
      }

      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TimeBlock>> moveTimeBlock(
      String id, DateTime newStartTime) async {
    try {
      final model = await localDataSource.getTimeBlockById(id);
      if (model == null) {
        return Left(CacheFailure(message: 'TimeBlock not found'));
      }

      final duration = model.endTime.difference(model.startTime);
      final newEndTime = newStartTime.add(duration);

      final updatedModel = model.copyWith(
        startTime: newStartTime,
        endTime: newEndTime,
      );

      final savedModel = await localDataSource.saveTimeBlock(updatedModel);
      return Right(savedModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TimeBlock>> resizeTimeBlock(
      String id, DateTime newStartTime, DateTime newEndTime) async {
    try {
      final model = await localDataSource.getTimeBlockById(id);
      if (model == null) {
        return Left(CacheFailure(message: 'TimeBlock not found'));
      }

      final updatedModel = model.copyWith(
        startTime: newStartTime,
        endTime: newEndTime,
      );

      final savedModel = await localDataSource.saveTimeBlock(updatedModel);
      return Right(savedModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TimeBlock>>> getConflictingTimeBlocks(
    DateTime startTime,
    DateTime endTime, {
    String? excludeId,
  }) async {
    try {
      final models = await localDataSource.getTimeBlocksForRange(
        startTime,
        endTime,
      );

      final conflicts = models
          .where((m) =>
              (excludeId == null || m.id != excludeId) &&
              DateTimeUtils.isOverlapping(
                start1: m.startTime,
                end1: m.endTime,
                start2: startTime,
                end2: endTime,
              ))
          .map((m) => m.toEntity())
          .toList();

      return Right(conflicts);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TimeBlock>> updateTimeBlockStatus(
      String id, TimeBlockStatus status) async {
    try {
      final model = await localDataSource.getTimeBlockById(id);
      if (model == null) {
        return Left(CacheFailure(message: 'TimeBlock not found'));
      }

      final updatedModel = model.copyWith(status: status.name);
      final savedModel = await localDataSource.saveTimeBlock(updatedModel);

      // 통계 캐시 무효화
      if (analyticsDataSource != null) {
        final date = DateTime(
          savedModel.startTime.year,
          savedModel.startTime.month,
          savedModel.startTime.day,
        );
        await analyticsDataSource!.deleteDailyStatsSummary(date);
      }

      return Right(savedModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TimeBlock>> recordActualTime(
    String id, {
    DateTime? actualStart,
    DateTime? actualEnd,
  }) async {
    try {
      final model = await localDataSource.getTimeBlockById(id);
      if (model == null) {
        return Left(CacheFailure(message: 'TimeBlock not found'));
      }

      final updatedModel = model.copyWith(
        actualStart: actualStart ?? model.actualStart,
        actualEnd: actualEnd ?? model.actualEnd,
      );

      final savedModel = await localDataSource.saveTimeBlock(updatedModel);
      return Right(savedModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<TimeBlock>>> watchTimeBlocksForDay(
      DateTime date) {
    return localDataSource.watchTimeBlocksForDay(date).map((models) {
      try {
        final timeBlocks = models.map((m) => m.toEntity()).toList();
        return Right<Failure, List<TimeBlock>>(timeBlocks);
      } catch (e) {
        return Left<Failure, List<TimeBlock>>(
            UnknownFailure(message: e.toString()));
      }
    });
  }
}
