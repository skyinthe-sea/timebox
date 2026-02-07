import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../features/analytics/data/datasources/analytics_local_datasource.dart';
import '../../features/focus/data/datasources/focus_session_local_datasource.dart';
import '../../features/focus/data/models/focus_session_model.dart';
import '../../features/task/data/datasources/task_local_datasource.dart';
import '../../features/task/data/models/tag_model.dart';
import '../../features/task/data/models/task_model.dart';
import '../../features/timeblock/data/datasources/time_block_local_datasource.dart';
import '../../features/timeblock/data/models/time_block_model.dart';
import '../../features/timeblock/domain/entities/time_block.dart';
import '../models/sample_data_texts.dart';
import 'demo_mode_service.dart';
import 'stats_update_service.dart';

/// 샘플 데이터 시더
///
/// 데모 모드 활성화 시 샘플 데이터 생성 및 삭제
class SampleDataSeeder {
  final TaskLocalDataSource _taskDataSource;
  final TimeBlockLocalDataSource _timeBlockDataSource;
  final FocusSessionLocalDataSource _focusSessionDataSource;
  final DemoModeService _demoModeService;
  final StatsUpdateService? _statsUpdateService;
  final AnalyticsLocalDataSource? _analyticsDataSource;

  final _random = Random();

  SampleDataSeeder({
    required TaskLocalDataSource taskDataSource,
    required TimeBlockLocalDataSource timeBlockDataSource,
    required FocusSessionLocalDataSource focusSessionDataSource,
    required DemoModeService demoModeService,
    StatsUpdateService? statsUpdateService,
    AnalyticsLocalDataSource? analyticsDataSource,
  })  : _taskDataSource = taskDataSource,
        _timeBlockDataSource = timeBlockDataSource,
        _focusSessionDataSource = focusSessionDataSource,
        _demoModeService = demoModeService,
        _statsUpdateService = statsUpdateService,
        _analyticsDataSource = analyticsDataSource;

  /// 샘플 데이터 JSON 로드
  Future<SampleDataTexts> _loadSampleTexts(String locale) async {
    try {
      final jsonString = await rootBundle.loadString(
        'assets/sample_data/sample_data_$locale.json',
      );
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return SampleDataTexts.fromJson(json);
    } catch (e) {
      // fallback to English if locale not found
      final jsonString = await rootBundle.loadString(
        'assets/sample_data/sample_data_en.json',
      );
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return SampleDataTexts.fromJson(json);
    }
  }

  /// 데모 데이터 생성
  Future<void> seedData(String locale) async {
    // 기존 데모 데이터 삭제
    await clearDemoData();

    final texts = await _loadSampleTexts(locale);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // 과거 30일 데이터 생성
    for (int dayOffset = -30; dayOffset < 0; dayOffset++) {
      final date = today.add(Duration(days: dayOffset));
      await _generateDayData(texts, date, _getPastDistribution());
    }

    // 오늘 데이터 생성
    await _generateDayData(texts, today, _getTodayDistribution());

    // 미래 7일 데이터 생성
    for (int dayOffset = 1; dayOffset <= 7; dayOffset++) {
      final date = today.add(Duration(days: dayOffset));
      await _generateDayData(texts, date, _getFutureDistribution());
    }

    await _demoModeService.markDataGenerated(locale);

    // 통계 캐시 리빌드 (과거 30일 + 오늘)
    final statsService = _statsUpdateService;
    if (statsService != null) {
      final rangeStart = today.subtract(const Duration(days: 30));
      await statsService.recalculateRange(rangeStart, today);
    }
  }

  /// 데모 데이터 삭제
  Future<void> clearDemoData() async {
    // Tasks 삭제
    final tasks = await _taskDataSource.getTasks();
    for (final task in tasks) {
      if (DemoModeService.isDemoId(task.id)) {
        await _taskDataSource.deleteTask(task.id);
      }
    }

    // TimeBlocks 삭제 - 전체 기간 조회
    final now = DateTime.now();
    final start = now.subtract(const Duration(days: 60));
    final end = now.add(const Duration(days: 30));
    final timeBlocks = await _timeBlockDataSource.getTimeBlocksForRange(start, end);
    for (final block in timeBlocks) {
      if (DemoModeService.isDemoId(block.id)) {
        await _timeBlockDataSource.deleteTimeBlock(block.id);
      }
    }

    // FocusSessions 삭제
    final sessions = await _focusSessionDataSource.getAllSessions();
    for (final session in sessions) {
      if (DemoModeService.isDemoId(session.id)) {
        await _focusSessionDataSource.deleteSession(session.id);
      }
    }

    // 통계 캐시 전체 삭제 + 오늘 통계 재계산
    final statsService = _statsUpdateService;
    final analyticsDS = _analyticsDataSource;
    if (statsService != null) {
      await statsService.clearAllCaches();
      await statsService.ensureTodayStats();
    } else if (analyticsDS != null) {
      await analyticsDS.clearAllPeriodCaches();
    }
  }

  /// 과거 데이터 분포 (완료 65-80%, 건너뜀 10-20%, 지연 5-15%)
  _StatusDistribution _getPastDistribution() {
    return _StatusDistribution(
      completed: 0.72,
      inProgress: 0.0,
      pending: 0.0,
      skipped: 0.15,
      delayed: 0.13,
    );
  }

  /// 오늘 데이터 분포 (완료 30%, 진행중 20%, 대기 40%, 건너뜀 5%, 지연 5%)
  _StatusDistribution _getTodayDistribution() {
    return _StatusDistribution(
      completed: 0.30,
      inProgress: 0.20,
      pending: 0.40,
      skipped: 0.05,
      delayed: 0.05,
    );
  }

  /// 미래 데이터 분포 (대기 100%)
  _StatusDistribution _getFutureDistribution() {
    return _StatusDistribution(
      completed: 0.0,
      inProgress: 0.0,
      pending: 1.0,
      skipped: 0.0,
      delayed: 0.0,
    );
  }

  /// 하루치 데이터 생성
  Future<void> _generateDayData(
    SampleDataTexts texts,
    DateTime date,
    _StatusDistribution distribution,
  ) async {
    // 하루에 5-8개의 태스크를 랜덤하게 선택
    final taskCount = 5 + _random.nextInt(4);
    final shuffledTasks = List<SampleTaskText>.from(texts.tasks)..shuffle(_random);
    final selectedTasks = shuffledTasks.take(taskCount).toList();

    // 시간대별로 정렬
    selectedTasks.sort((a, b) {
      final aSlot = TimeSlotExtension.fromString(a.timeSlot);
      final bSlot = TimeSlotExtension.fromString(b.timeSlot);
      return aSlot.hourRange.$1.compareTo(bSlot.hourRange.$1);
    });

    int currentHour = 6;

    for (int i = 0; i < selectedTasks.length; i++) {
      final taskText = selectedTasks[i];
      final status = _pickStatus(distribution);
      final timeSlot = TimeSlotExtension.fromString(taskText.timeSlot);

      // 시간대 내에서 랜덤한 시작 시간
      final (slotStart, slotEnd) = timeSlot.hourRange;
      if (currentHour < slotStart) {
        currentHour = slotStart;
      }
      final maxStartHour = slotEnd - 1;
      if (currentHour > maxStartHour) {
        currentHour = maxStartHour;
      }

      final startMinute = _random.nextInt(2) * 30; // 0 or 30
      final startTime = DateTime(
        date.year,
        date.month,
        date.day,
        currentHour,
        startMinute,
      );
      final endTime = startTime.add(Duration(minutes: taskText.durationMinutes));

      // Task 생성
      final taskId = DemoModeService.createDemoId('task_${date.millisecondsSinceEpoch}_$i');
      final tagModel = _getTagModelForId(taskText.tagId, texts.tagNames);
      final task = TaskModel(
        id: taskId,
        title: taskText.title,
        note: taskText.note,
        estimatedDurationMinutes: taskText.durationMinutes,
        tags: [tagModel],
        priority: taskText.priority,
        status: _mapToTaskStatusString(status),
        subtasks: const [],
        createdAt: date.subtract(const Duration(days: 1)),
        completedAt: status == TimeBlockStatus.completed ? endTime : null,
        targetDate: date,
        rolloverCount: 0,
      );
      await _taskDataSource.saveTask(task);

      // TimeBlock 생성
      final timeBlockId = DemoModeService.createDemoId('tb_${date.millisecondsSinceEpoch}_$i');
      // actualStart/actualEnd는 null로 설정 (해당 기능 UI가 없음)
      const DateTime? actualStart = null;
      const DateTime? actualEnd = null;

      final timeBlock = TimeBlockModel(
        id: timeBlockId,
        taskId: taskId,
        startTime: startTime,
        endTime: endTime,
        actualStart: actualStart,
        actualEnd: actualEnd,
        isExternal: false,
        status: status.name,
        title: taskText.title,
        colorValue: tagModel.colorValue,
      );
      await _timeBlockDataSource.saveTimeBlock(timeBlock);

      // 완료된 블록에 대해 FocusSession 생성
      if (status == TimeBlockStatus.completed) {
        final sessionId = DemoModeService.createDemoId('fs_${date.millisecondsSinceEpoch}_$i');
        final session = FocusSessionModel(
          id: sessionId,
          timeBlockId: timeBlockId,
          taskId: taskId,
          status: 'completed',
          plannedStartTime: startTime,
          plannedEndTime: endTime,
          actualStartTime: actualStart,
          actualEndTime: actualEnd,
          pauseRecords: const [],
          createdAt: startTime,
        );
        await _focusSessionDataSource.saveSession(session);
      }

      // 다음 블록 시작 시간 업데이트
      currentHour = endTime.hour;
      if (endTime.minute >= 30) {
        currentHour++;
      }
    }
  }

  /// 분포에 따라 상태 선택
  TimeBlockStatus _pickStatus(_StatusDistribution dist) {
    final rand = _random.nextDouble();
    if (rand < dist.completed) return TimeBlockStatus.completed;
    if (rand < dist.completed + dist.inProgress) return TimeBlockStatus.inProgress;
    if (rand < dist.completed + dist.inProgress + dist.pending) return TimeBlockStatus.pending;
    if (rand < dist.completed + dist.inProgress + dist.pending + dist.skipped) {
      return TimeBlockStatus.skipped;
    }
    return TimeBlockStatus.delayed;
  }

  String _mapToTaskStatusString(TimeBlockStatus status) {
    switch (status) {
      case TimeBlockStatus.completed:
        return 'done';
      case TimeBlockStatus.skipped:
      case TimeBlockStatus.delayed:
      default:
        return 'todo';
    }
  }

  TagModel _getTagModelForId(String tagId, Map<String, String> tagNames) {
    final name = tagNames[tagId] ?? tagId;
    switch (tagId) {
      case 'work':
        return TagModel(
          id: tagId,
          name: name,
          colorValue: const Color(0xFF3B82F6).toARGB32(),
          iconCodePoint: Icons.work.codePoint.toString(),
        );
      case 'personal':
        return TagModel(
          id: tagId,
          name: name,
          colorValue: const Color(0xFF10B981).toARGB32(),
          iconCodePoint: Icons.person.codePoint.toString(),
        );
      case 'health':
        return TagModel(
          id: tagId,
          name: name,
          colorValue: const Color(0xFFEF4444).toARGB32(),
          iconCodePoint: Icons.favorite.codePoint.toString(),
        );
      case 'study':
        return TagModel(
          id: tagId,
          name: name,
          colorValue: const Color(0xFFF59E0B).toARGB32(),
          iconCodePoint: Icons.school.codePoint.toString(),
        );
      default:
        return TagModel(
          id: tagId,
          name: name,
          colorValue: const Color(0xFF6366F1).toARGB32(),
        );
    }
  }
}

/// 상태 분포
class _StatusDistribution {
  final double completed;
  final double inProgress;
  final double pending;
  final double skipped;
  final double delayed;

  const _StatusDistribution({
    required this.completed,
    required this.inProgress,
    required this.pending,
    required this.skipped,
    required this.delayed,
  });
}
