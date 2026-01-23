import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../notification/domain/entities/notification_settings.dart';
import '../../../notification/domain/repositories/notification_repository.dart';

part 'settings_state.dart';

/// Settings Cubit
///
/// 앱 설정 상태 관리
class SettingsCubit extends Cubit<SettingsState> {
  final NotificationRepository? notificationRepository;

  SettingsCubit({this.notificationRepository}) : super(const SettingsState()) {
    _loadNotificationSettings();
  }

  /// 알림 설정 로드
  Future<void> _loadNotificationSettings() async {
    if (notificationRepository == null) return;

    final result = await notificationRepository!.getSettings();
    result.fold(
      (_) => {},
      (settings) {
        emit(state.copyWith(
          notificationsEnabled: settings.enabled,
          startAlarmEnabled: settings.startAlarmEnabled,
          endAlarmEnabled: settings.endAlarmEnabled,
          minutesBeforeStart: settings.minutesBeforeStart,
          minutesBeforeEnd: settings.minutesBeforeEnd,
          dailyReminderEnabled: settings.dailyReminderEnabled,
          dailyReminderHour: settings.dailyReminderHour,
          dailyReminderMinute: settings.dailyReminderMinute,
        ));
      },
    );

    // 권한 상태 확인
    final permResult = await notificationRepository!.hasPermissions();
    permResult.fold(
      (_) => {},
      (hasPermission) {
        emit(state.copyWith(hasNotificationPermission: hasPermission));
      },
    );
  }

  /// 알림 설정 저장
  Future<void> _saveNotificationSettings() async {
    if (notificationRepository == null) return;

    final settings = NotificationSettings(
      enabled: state.notificationsEnabled,
      startAlarmEnabled: state.startAlarmEnabled,
      endAlarmEnabled: state.endAlarmEnabled,
      minutesBeforeStart: state.minutesBeforeStart,
      minutesBeforeEnd: state.minutesBeforeEnd,
      dailyReminderEnabled: state.dailyReminderEnabled,
      dailyReminderHour: state.dailyReminderHour,
      dailyReminderMinute: state.dailyReminderMinute,
    );

    await notificationRepository!.saveSettings(settings);
  }

  /// 테마 모드 변경
  void setThemeMode(ThemeMode themeMode) {
    emit(state.copyWith(themeMode: themeMode));
  }

  /// 언어 변경
  void setLocale(Locale locale) {
    emit(state.copyWith(locale: locale));
  }

  /// 기본 타임블록 길이 변경
  void setDefaultDuration(int minutes) {
    emit(state.copyWith(defaultTimeBlockMinutes: minutes));
  }

  /// 하루 시작 시간 변경
  void setDayStartHour(int hour) {
    emit(state.copyWith(dayStartHour: hour));
  }

  /// 하루 종료 시간 변경
  void setDayEndHour(int hour) {
    emit(state.copyWith(dayEndHour: hour));
  }

  /// 알림 권한 요청
  Future<bool> requestNotificationPermissions() async {
    if (notificationRepository == null) return false;

    final result = await notificationRepository!.requestPermissions();
    return result.fold(
      (_) => false,
      (granted) {
        emit(state.copyWith(hasNotificationPermission: granted));
        return granted;
      },
    );
  }

  /// 알림 마스터 토글
  Future<void> setNotificationsEnabled(bool enabled) async {
    emit(state.copyWith(notificationsEnabled: enabled));
    await _saveNotificationSettings();

    // 알림 비활성화 시 모든 알림 취소
    if (!enabled) {
      await notificationRepository?.cancelAllNotifications();
    }
  }

  /// 시작 알림 토글
  Future<void> setStartAlarmEnabled(bool enabled) async {
    emit(state.copyWith(startAlarmEnabled: enabled));
    await _saveNotificationSettings();
  }

  /// 종료 알림 토글
  Future<void> setEndAlarmEnabled(bool enabled) async {
    emit(state.copyWith(endAlarmEnabled: enabled));
    await _saveNotificationSettings();
  }

  /// 시작 전 알림 시간 설정 (다중 선택)
  Future<void> setMinutesBeforeStart(List<int> minutes) async {
    if (minutes.isEmpty) return;
    emit(state.copyWith(minutesBeforeStart: List<int>.from(minutes)..sort()));
    await _saveNotificationSettings();
  }

  /// 종료 전 알림 시간 설정 (다중 선택)
  Future<void> setMinutesBeforeEnd(List<int> minutes) async {
    if (minutes.isEmpty) return;
    emit(state.copyWith(minutesBeforeEnd: List<int>.from(minutes)..sort()));
    await _saveNotificationSettings();
  }

  /// 일일 리마인더 토글
  Future<void> setDailyReminderEnabled(bool enabled) async {
    emit(state.copyWith(dailyReminderEnabled: enabled));
    await _saveNotificationSettings();

    if (!enabled) {
      await notificationRepository?.cancelDailyReminder();
    }
  }

  /// 일일 리마인더 시간 설정
  Future<void> setDailyReminderTime(int hour, int minute) async {
    emit(state.copyWith(
      dailyReminderHour: hour,
      dailyReminderMinute: minute,
    ));
    await _saveNotificationSettings();
  }

  /// 설정 초기화
  Future<void> resetToDefaults() async {
    emit(const SettingsState());
    await _saveNotificationSettings();
  }
}
