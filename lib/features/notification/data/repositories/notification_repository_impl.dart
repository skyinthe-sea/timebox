import 'dart:convert';
import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/services/notification_service.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../timeblock/domain/entities/time_block.dart';
import '../../domain/entities/notification_settings.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_local_datasource.dart';

/// 알림 레포지토리 구현
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationService _notificationService;
  final NotificationLocalDataSource _localDataSource;
  final SharedPreferences _prefs;

  NotificationRepositoryImpl({
    required NotificationService notificationService,
    required NotificationLocalDataSource localDataSource,
    required SharedPreferences prefs,
  })  : _notificationService = notificationService,
        _localDataSource = localDataSource,
        _prefs = prefs;

  /// 저장된 locale에 기반한 AppLocalizations 인스턴스
  AppLocalizations get _l10n {
    final langCode = _prefs.getString('settings_locale') ?? 'ko';
    return lookupAppLocalizations(Locale(langCode));
  }

  @override
  Future<Either<Failure, NotificationSettings>> getSettings() async {
    try {
      final settings = _localDataSource.getSettings();
      return Right(settings);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load settings.'));
    }
  }

  @override
  Future<Either<Failure, void>> saveSettings(
      NotificationSettings settings) async {
    try {
      await _localDataSource.saveSettings(settings);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to save settings.'));
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
      final l10n = _l10n;

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
            title: l10n.timeBlockStartAlarmTitle(title, _formatTimeLabel(minutes, l10n)),
            body: l10n.timeBlockStartAlarmBody,
            scheduledTime: alarmTime,
            channelType: NotificationChannelType.alarms,
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
            title: l10n.timeBlockEndAlarmTitle(title, _formatTimeLabel(minutes, l10n)),
            body: l10n.timeBlockEndAlarmBody,
            scheduledTime: alarmTime,
            channelType: NotificationChannelType.alarms,
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
      return Left(UnknownFailure(message: 'Failed to schedule notification.'));
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
      return Left(UnknownFailure(message: 'Failed to cancel notification.'));
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
        channelType: NotificationChannelType.reminders,
        payload: jsonEncode({'type': 'daily_engagement'}),
      );

      return const Right(null);
    } catch (e) {
      debugPrint('Failed to schedule daily reminder: $e');
      return Left(UnknownFailure(message: 'Failed to schedule daily reminder.'));
    }
  }

  @override
  Future<Either<Failure, void>> cancelDailyReminder() async {
    try {
      await _notificationService
          .cancelNotification(NotificationIdGenerator.dailyEngagement);
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure(message: 'Failed to cancel daily reminder.'));
    }
  }

  @override
  Future<Either<Failure, void>> cancelAllNotifications() async {
    try {
      await _notificationService.cancelAllNotifications();
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure(message: 'Failed to cancel all notifications.'));
    }
  }

  @override
  Future<Either<Failure, bool>> requestPermissions() async {
    try {
      final granted = await _notificationService.requestPermissions();
      return Right(granted);
    } catch (e) {
      return Left(UnknownFailure(message: 'Failed to request permissions.'));
    }
  }

  @override
  Future<Either<Failure, bool>> hasPermissions() async {
    try {
      final hasPerms = await _notificationService.hasPermissions();
      return Right(hasPerms);
    } catch (e) {
      return Left(UnknownFailure(message: 'Failed to check permissions.'));
    }
  }

  /// 분 단위를 사람이 읽을 수 있는 시간 라벨로 변환
  String _formatTimeLabel(int minutes, AppLocalizations l10n) {
    if (minutes >= 60) {
      final hours = minutes ~/ 60;
      return l10n.hoursShort(hours);
    }
    return l10n.minutesShort(minutes);
  }
}
