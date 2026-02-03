import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/services/hive_service.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../models/time_block_model.dart';

/// TimeBlock 로컬 데이터 소스 인터페이스
abstract class TimeBlockLocalDataSource {
  Future<List<TimeBlockModel>> getTimeBlocksForDay(DateTime date);
  Future<List<TimeBlockModel>> getTimeBlocksForRange(
      DateTime start, DateTime end);
  Future<TimeBlockModel?> getTimeBlockById(String id);
  Future<TimeBlockModel> saveTimeBlock(TimeBlockModel timeBlock);
  Future<void> deleteTimeBlock(String id);
  Stream<List<TimeBlockModel>> watchTimeBlocksForDay(DateTime date);
}

/// TimeBlock 로컬 데이터 소스 구현 (Hive)
class TimeBlockLocalDataSourceImpl implements TimeBlockLocalDataSource {
  Box<Map> get _box => HiveService.getTimeBlocksBox();

  @override
  Future<List<TimeBlockModel>> getTimeBlocksForDay(DateTime date) async {
    try {
      final dayStart = DateTimeUtils.startOfDay(date);
      final dayEnd = DateTimeUtils.endOfDay(date);

      final timeBlocks = <TimeBlockModel>[];
      for (final key in _box.keys) {
        final data = _box.get(key);
        if (data != null) {
          final model =
              TimeBlockModel.fromJson(Map<String, dynamic>.from(data));
          // 해당 날짜에 걸치는 블록만 포함
          if (model.startTime.isBefore(dayEnd) &&
              model.endTime.isAfter(dayStart)) {
            timeBlocks.add(model);
          }
        }
      }

      // 시작 시간 기준 정렬
      timeBlocks.sort((a, b) => a.startTime.compareTo(b.startTime));
      return timeBlocks;
    } catch (e) {
      throw CacheException(message: 'Failed to get time blocks: $e');
    }
  }

  @override
  Future<List<TimeBlockModel>> getTimeBlocksForRange(
      DateTime start, DateTime end) async {
    try {
      final timeBlocks = <TimeBlockModel>[];
      for (final key in _box.keys) {
        final data = _box.get(key);
        if (data != null) {
          final model =
              TimeBlockModel.fromJson(Map<String, dynamic>.from(data));
          if (model.startTime.isBefore(end) && model.endTime.isAfter(start)) {
            timeBlocks.add(model);
          }
        }
      }

      timeBlocks.sort((a, b) => a.startTime.compareTo(b.startTime));
      return timeBlocks;
    } catch (e) {
      throw CacheException(message: 'Failed to get time blocks: $e');
    }
  }

  @override
  Future<TimeBlockModel?> getTimeBlockById(String id) async {
    try {
      final data = _box.get(id);
      if (data == null) return null;
      return TimeBlockModel.fromJson(Map<String, dynamic>.from(data));
    } catch (e) {
      throw CacheException(message: 'Failed to get time block: $e');
    }
  }

  @override
  Future<TimeBlockModel> saveTimeBlock(TimeBlockModel timeBlock) async {
    try {
      await _box.put(timeBlock.id, timeBlock.toJson());
      return timeBlock;
    } catch (e) {
      throw CacheException(message: 'Failed to save time block: $e');
    }
  }

  @override
  Future<void> deleteTimeBlock(String id) async {
    try {
      await _box.delete(id);
    } catch (e) {
      throw CacheException(message: 'Failed to delete time block: $e');
    }
  }

  @override
  Stream<List<TimeBlockModel>> watchTimeBlocksForDay(DateTime date) {
    final controller = StreamController<List<TimeBlockModel>>();

    // 초기 데이터 전송
    getTimeBlocksForDay(date).then((timeBlocks) {
      if (!controller.isClosed) {
        controller.add(timeBlocks);
      }
    });

    // 변경 감지
    final subscription = _box.watch().listen((_) async {
      if (!controller.isClosed) {
        final timeBlocks = await getTimeBlocksForDay(date);
        controller.add(timeBlocks);
      }
    });

    controller.onCancel = () {
      subscription.cancel();
      controller.close();
    };

    return controller.stream;
  }
}
