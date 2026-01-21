import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/services/hive_service.dart';
import '../models/daily_priority_model.dart';

/// DailyPriority 로컬 데이터 소스 인터페이스
abstract class DailyPriorityLocalDataSource {
  /// 특정 날짜의 DailyPriority 조회
  Future<DailyPriorityModel?> getDailyPriority(DateTime date);

  /// DailyPriority 저장 (생성/수정)
  Future<DailyPriorityModel> saveDailyPriority(DailyPriorityModel model);

  /// DailyPriority 삭제
  Future<void> deleteDailyPriority(DateTime date);

  /// 날짜 범위의 DailyPriority 목록 조회
  Future<List<DailyPriorityModel>> getDailyPrioritiesInRange({
    required DateTime startDate,
    required DateTime endDate,
  });

  /// DailyPriority 스트림 (실시간 업데이트)
  Stream<DailyPriorityModel?> watchDailyPriority(DateTime date);
}

/// DailyPriority 로컬 데이터 소스 구현 (Hive)
class DailyPriorityLocalDataSourceImpl implements DailyPriorityLocalDataSource {
  final Uuid _uuid = const Uuid();

  Box<Map> get _box => HiveService.getDailyPrioritiesBox();

  /// 날짜 키 생성 (yyyy-MM-dd 형식)
  String _dateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Future<DailyPriorityModel?> getDailyPriority(DateTime date) async {
    try {
      final key = _dateKey(date);
      final data = _box.get(key);
      if (data == null) return null;
      return DailyPriorityModel.fromJson(Map<String, dynamic>.from(data));
    } catch (e) {
      throw CacheException(message: 'Failed to get daily priority: $e');
    }
  }

  @override
  Future<DailyPriorityModel> saveDailyPriority(DailyPriorityModel model) async {
    try {
      final key = model.dateKey;
      // 기존 데이터가 없으면 새 ID 생성
      final existing = await getDailyPriority(model.date);
      final modelToSave = existing == null
          ? model.copyWith(id: _uuid.v4())
          : model.copyWith(id: existing.id);

      await _box.put(key, modelToSave.toJson());
      return modelToSave;
    } catch (e) {
      throw CacheException(message: 'Failed to save daily priority: $e');
    }
  }

  @override
  Future<void> deleteDailyPriority(DateTime date) async {
    try {
      final key = _dateKey(date);
      await _box.delete(key);
    } catch (e) {
      throw CacheException(message: 'Failed to delete daily priority: $e');
    }
  }

  @override
  Future<List<DailyPriorityModel>> getDailyPrioritiesInRange({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final results = <DailyPriorityModel>[];
      var current = DateTime(startDate.year, startDate.month, startDate.day);
      final end = DateTime(endDate.year, endDate.month, endDate.day);

      while (!current.isAfter(end)) {
        final key = _dateKey(current);
        final data = _box.get(key);
        if (data != null) {
          results.add(
            DailyPriorityModel.fromJson(Map<String, dynamic>.from(data)),
          );
        }
        current = current.add(const Duration(days: 1));
      }

      return results;
    } catch (e) {
      throw CacheException(message: 'Failed to get daily priorities in range: $e');
    }
  }

  @override
  Stream<DailyPriorityModel?> watchDailyPriority(DateTime date) {
    final controller = StreamController<DailyPriorityModel?>();
    final key = _dateKey(date);

    // 초기 데이터 전송
    getDailyPriority(date).then((model) {
      if (!controller.isClosed) {
        controller.add(model);
      }
    });

    // 변경 감지
    final subscription = _box.watch(key: key).listen((_) async {
      if (!controller.isClosed) {
        final model = await getDailyPriority(date);
        controller.add(model);
      }
    });

    controller.onCancel = () {
      subscription.cancel();
    };

    return controller.stream;
  }
}
