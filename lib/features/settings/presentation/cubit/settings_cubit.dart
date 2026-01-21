import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_state.dart';

/// Settings Cubit
///
/// 앱 설정 상태 관리
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  /// 테마 모드 변경
  void setThemeMode(ThemeMode themeMode) {
    emit(state.copyWith(themeMode: themeMode));
  }

  /// 언어 변경
  void setLocale(Locale locale) {
    emit(state.copyWith(locale: locale));
  }

  /// 알림 토글
  void toggleNotifications() {
    emit(state.copyWith(notificationsEnabled: !state.notificationsEnabled));
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

  /// 알림 활성화/비활성화
  void setNotificationsEnabled(bool enabled) {
    emit(state.copyWith(notificationsEnabled: enabled));
  }

  /// 알림 시간 변경 (분 전)
  void setNotificationBeforeMinutes(int minutes) {
    emit(state.copyWith(notificationBeforeMinutes: minutes));
  }

  /// 설정 초기화
  void resetToDefaults() {
    emit(const SettingsState());
  }
}
