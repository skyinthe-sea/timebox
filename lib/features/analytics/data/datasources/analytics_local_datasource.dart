import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/services/hive_service.dart';
import '../models/daily_stats_summary_model.dart';

/// Analytics 로컬 데이터 소스 인터페이스
abstract class AnalyticsLocalDataSource {
  /// 특정 날짜의 통계 요약 조회
  Future<DailyStatsSummaryModel?> getDailyStatsSummary(DateTime date);

  /// 날짜 범위의 통계 요약 목록 조회
  Future<List<DailyStatsSummaryModel>> getDailyStatsSummaryRange(
    DateTime start,
    DateTime end,
  );

  /// 통계 요약 저장
  Future<DailyStatsSummaryModel> saveDailyStatsSummary(
      DailyStatsSummaryModel summary);

  /// 통계 요약 삭제
  Future<void> deleteDailyStatsSummary(DateTime date);

  /// 통계 요약 스트림 (실시간 업데이트)
  Stream<DailyStatsSummaryModel?> watchDailyStatsSummary(DateTime date);

  /// 모든 통계 요약 개수
  Future<int> getStatsSummaryCount();

  /// 가장 오래된 통계 날짜
  Future<DateTime?> getOldestStatsDate();

  /// 가장 최근 통계 날짜
  Future<DateTime?> getLatestStatsDate();
}

/// Analytics 로컬 데이터 소스 구현 (Hive)
class AnalyticsLocalDataSourceImpl implements AnalyticsLocalDataSource {
  Box<Map> get _statsBox => HiveService.getDailyStatsSummaryBox();

  /// 날짜를 키로 변환 (yyyy-MM-dd)
  String _dateToKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Future<DailyStatsSummaryModel?> getDailyStatsSummary(DateTime date) async {
    try {
      final key = _dateToKey(date);
      final data = _statsBox.get(key);
      if (data == null) return null;
      return DailyStatsSummaryModel.fromJson(Map<String, dynamic>.from(data));
    } catch (e) {
      throw CacheException(message: 'Failed to get daily stats summary: $e');
    }
  }

  @override
  Future<List<DailyStatsSummaryModel>> getDailyStatsSummaryRange(
    DateTime start,
    DateTime end,
  ) async {
    try {
      final summaries = <DailyStatsSummaryModel>[];
      final startDate = DateTime(start.year, start.month, start.day);
      final endDate = DateTime(end.year, end.month, end.day);

      for (final key in _statsBox.keys) {
        final data = _statsBox.get(key);
        if (data != null) {
          final summary =
              DailyStatsSummaryModel.fromJson(Map<String, dynamic>.from(data));
          final summaryDate =
              DateTime(summary.date.year, summary.date.month, summary.date.day);

          if (!summaryDate.isBefore(startDate) &&
              !summaryDate.isAfter(endDate)) {
            summaries.add(summary);
          }
        }
      }

      // 날짜순 정렬
      summaries.sort((a, b) => a.date.compareTo(b.date));
      return summaries;
    } catch (e) {
      throw CacheException(
          message: 'Failed to get daily stats summary range: $e');
    }
  }

  @override
  Future<DailyStatsSummaryModel> saveDailyStatsSummary(
      DailyStatsSummaryModel summary) async {
    try {
      final key = _dateToKey(summary.date);
      await _statsBox.put(key, summary.toJson());
      return summary;
    } catch (e) {
      throw CacheException(message: 'Failed to save daily stats summary: $e');
    }
  }

  @override
  Future<void> deleteDailyStatsSummary(DateTime date) async {
    try {
      final key = _dateToKey(date);
      await _statsBox.delete(key);
    } catch (e) {
      throw CacheException(message: 'Failed to delete daily stats summary: $e');
    }
  }

  @override
  Stream<DailyStatsSummaryModel?> watchDailyStatsSummary(DateTime date) {
    final controller = StreamController<DailyStatsSummaryModel?>();
    final key = _dateToKey(date);

    // 초기 데이터 전송
    getDailyStatsSummary(date).then((summary) {
      if (!controller.isClosed) {
        controller.add(summary);
      }
    });

    // 변경 감지
    final subscription = _statsBox.watch(key: key).listen((_) async {
      if (!controller.isClosed) {
        final summary = await getDailyStatsSummary(date);
        controller.add(summary);
      }
    });

    controller.onCancel = () {
      subscription.cancel();
    };

    return controller.stream;
  }

  @override
  Future<int> getStatsSummaryCount() async {
    return _statsBox.length;
  }

  @override
  Future<DateTime?> getOldestStatsDate() async {
    try {
      DateTime? oldest;
      for (final key in _statsBox.keys) {
        final data = _statsBox.get(key);
        if (data != null) {
          final summary =
              DailyStatsSummaryModel.fromJson(Map<String, dynamic>.from(data));
          if (oldest == null || summary.date.isBefore(oldest)) {
            oldest = summary.date;
          }
        }
      }
      return oldest;
    } catch (e) {
      throw CacheException(message: 'Failed to get oldest stats date: $e');
    }
  }

  @override
  Future<DateTime?> getLatestStatsDate() async {
    try {
      DateTime? latest;
      for (final key in _statsBox.keys) {
        final data = _statsBox.get(key);
        if (data != null) {
          final summary =
              DailyStatsSummaryModel.fromJson(Map<String, dynamic>.from(data));
          if (latest == null || summary.date.isAfter(latest)) {
            latest = summary.date;
          }
        }
      }
      return latest;
    } catch (e) {
      throw CacheException(message: 'Failed to get latest stats date: $e');
    }
  }
}
