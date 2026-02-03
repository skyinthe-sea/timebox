import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/services/notification_service.dart';
import '../../../timeblock/domain/entities/time_block.dart';
import '../../domain/entities/notification_settings.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_local_datasource.dart';

/// 알림 레포지토리 구현
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationService _notificationService;
  final NotificationLocalDataSource _localDataSource;

  NotificationRepositoryImpl({
    required NotificationService notificationService,
    required NotificationLocalDataSource localDataSource,
  })  : _notificationService = notificationService,
        _localDataSource = localDataSource;

  @override
  Future<Either<Failure, NotificationSettings>> getSettings() async {
    try {
      final settings = _localDataSource.getSettings();
      return Right(settings);
    } catch (e) {
      return Left(CacheFailure(message: '설정을 불러오는데 실패했습니다.'));
    }
  }

  @override
  Future<Either<Failure, void>> saveSettings(
      NotificationSettings settings) async {
    try {
      await _localDataSource.saveSettings(settings);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: '설정 저장에 실패했습니다.'));
    }
  }

  @override
  Future<Either<Failure, void>> scheduleTimeBlockAlarms(
    TimeBlock timeBlock, {
    String? taskTitle,
  }) async {
    try {
      final settings = _localDataSource.getSettings();

      // 알림이 비활성화되어 있으면 스킵
      if (!settings.enabled) {
        return const Right(null);
      }

      // 이미 진행 중이거나 완료된 타임블록은 알림 설정 안 함
      if (timeBlock.status != TimeBlockStatus.pending) {
        return const Right(null);
      }

      final now = DateTime.now();
      final title = taskTitle ?? timeBlock.title ?? 'Timebox';

      // 시작 알림 스케줄링
      if (settings.startAlarmEnabled) {
        for (final minutes in settings.minutesBeforeStart) {
          final alarmTime =
              timeBlock.startTime.subtract(Duration(minutes: minutes));

          // 이미 지난 시간이면 스킵
          if (alarmTime.isBefore(now)) continue;

          // 타임블록 시작 시간이 현재 시간과 겹치면 스킵
          if (timeBlock.startTime.isBefore(now)) continue;

          await _notificationService.scheduleNotification(
            id: NotificationIdGenerator.forTimeBlockStart(timeBlock.id, minutes),
            title: _formatStartTitle(title, minutes),
            body: _formatStartBody(title),
            scheduledTime: alarmTime,
            payload: jsonEncode({
              'type': 'timeblock_start',
              'timeBlockId': timeBlock.id,
              'minutesBefore': minutes,
            }),
          );
        }
      }

      // 종료 알림 스케줄링
      if (settings.endAlarmEnabled) {
        for (final minutes in settings.minutesBeforeEnd) {
          final alarmTime =
              timeBlock.endTime.subtract(Duration(minutes: minutes));

          // 이미 지난 시간이면 스킵
          if (alarmTime.isBefore(now)) continue;

          // 타임블록 종료 시간이 현재 시간과 겹치면 스킵
          if (timeBlock.endTime.isBefore(now)) continue;

          await _notificationService.scheduleNotification(
            id: NotificationIdGenerator.forTimeBlockEnd(timeBlock.id, minutes),
            title: _formatEndTitle(title, minutes),
            body: _formatEndBody(title),
            scheduledTime: alarmTime,
            payload: jsonEncode({
              'type': 'timeblock_end',
              'timeBlockId': timeBlock.id,
              'minutesBefore': minutes,
            }),
          );
        }
      }

      return const Right(null);
    } catch (e) {
      debugPrint('Failed to schedule timeblock alarms: $e');
      return Left(UnknownFailure(message: '알림 예약에 실패했습니다.'));
    }
  }

  @override
  Future<Either<Failure, void>> cancelTimeBlockAlarms(
      String timeBlockId) async {
    try {
      final settings = _localDataSource.getSettings();

      // 해당 타임블록의 모든 알림 ID 생성
      final ids = _notificationService.getTimeBlockNotificationIds(
        timeBlockId,
        settings.minutesBeforeStart,
        settings.minutesBeforeEnd,
      );

      // 모든 알림 취소
      await _notificationService.cancelNotifications(ids);

      return const Right(null);
    } catch (e) {
      debugPrint('Failed to cancel timeblock alarms: $e');
      return Left(UnknownFailure(message: '알림 취소에 실패했습니다.'));
    }
  }

  @override
  Future<Either<Failure, void>> scheduleDailyReminder({
    required bool hasTimeBlocksToday,
    required String dailyReminderTitle,
    required String dailyReminderBody,
  }) async {
    try {
      final settings = _localDataSource.getSettings();

      // 알림이 비활성화되어 있거나 일일 리마인더가 꺼져 있으면 취소만
      if (!settings.enabled || !settings.dailyReminderEnabled) {
        await _notificationService
            .cancelNotification(NotificationIdGenerator.dailyEngagement);
        return const Right(null);
      }

      // 오늘 이미 계획이 있으면 알림 취소
      if (hasTimeBlocksToday) {
        await _notificationService
            .cancelNotification(NotificationIdGenerator.dailyEngagement);
        return const Right(null);
      }

      final now = DateTime.now();
      final hasOpenedToday = _localDataSource.hasOpenedAppToday();

      DateTime scheduledTime;

      if (hasOpenedToday) {
        // 오늘 앱을 열었으면 내일 알림
        scheduledTime = DateTime(
          now.year,
          now.month,
          now.day + 1,
          settings.dailyReminderHour,
          settings.dailyReminderMinute,
        );
      } else {
        // 오늘 앱을 안 열었으면, 오늘 알림 시간이 지났는지 확인
        final todayAlarmTime = DateTime(
          now.year,
          now.month,
          now.day,
          settings.dailyReminderHour,
          settings.dailyReminderMinute,
        );

        if (todayAlarmTime.isAfter(now)) {
          // 오늘 알림 시간이 아직 안 됐으면 오늘 알림
          scheduledTime = todayAlarmTime;
        } else {
          // 오늘 알림 시간이 지났으면 내일 알림
          scheduledTime = DateTime(
            now.year,
            now.month,
            now.day + 1,
            settings.dailyReminderHour,
            settings.dailyReminderMinute,
          );
        }
      }

      await _notificationService.scheduleNotification(
        id: NotificationIdGenerator.dailyEngagement,
        title: dailyReminderTitle,
        body: dailyReminderBody,
        scheduledTime: scheduledTime,
        payload: jsonEncode({'type': 'daily_engagement'}),
      );

      return const Right(null);
    } catch (e) {
      debugPrint('Failed to schedule daily reminder: $e');
      return Left(UnknownFailure(message: '일일 알림 예약에 실패했습니다.'));
    }
  }

  @override
  Future<Either<Failure, void>> cancelDailyReminder() async {
    try {
      await _notificationService
          .cancelNotification(NotificationIdGenerator.dailyEngagement);
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure(message: '일일 알림 취소에 실패했습니다.'));
    }
  }

  @override
  Future<Either<Failure, void>> cancelAllNotifications() async {
    try {
      await _notificationService.cancelAllNotifications();
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure(message: '알림 취소에 실패했습니다.'));
    }
  }

  @override
  Future<Either<Failure, bool>> requestPermissions() async {
    try {
      final granted = await _notificationService.requestPermissions();
      return Right(granted);
    } catch (e) {
      return Left(UnknownFailure(message: '권한 요청에 실패했습니다.'));
    }
  }

  @override
  Future<Either<Failure, bool>> hasPermissions() async {
    try {
      final hasPerms = await _notificationService.hasPermissions();
      return Right(hasPerms);
    } catch (e) {
      return Left(UnknownFailure(message: '권한 확인에 실패했습니다.'));
    }
  }

  // 알림 메시지 포맷팅 헬퍼 메서드
  String _formatStartTitle(String title, int minutes) {
    if (minutes >= 60) {
      final hours = minutes ~/ 60;
      return '$title - ${hours}h before start';
    }
    return '$title - ${minutes}m before start';
  }

  String _formatStartBody(String title) {
    return 'Starting soon. Get ready!';
  }

  String _formatEndTitle(String title, int minutes) {
    if (minutes >= 60) {
      final hours = minutes ~/ 60;
      return '$title - ${hours}h before end';
    }
    return '$title - ${minutes}m before end';
  }

  String _formatEndBody(String title) {
    return 'Time to wrap up.';
  }
}
