import 'package:flutter/material.dart';

/// UserSettings 엔티티
///
/// 사용자 설정을 나타내는 도메인 객체
class UserSettings {
  /// 테마 모드 (system, light, dark)
  final ThemeMode themeMode;

  /// 언어 코드 (ko, en, ja, hi, zh, fr, de)
  final String languageCode;

  /// 알림 활성화 여부
  final bool notificationsEnabled;

  /// 타임박스 시작 전 알림 (분)
  final int notifyBeforeStartMinutes;

  /// 타임박스 종료 전 알림 (분)
  final int notifyBeforeEndMinutes;

  /// 하루 시작 시간
  final int dayStartHour;

  /// 하루 종료 시간
  final int dayEndHour;

  /// 기본 타임박스 길이 (분)
  final int defaultTimeBlockMinutes;

  /// 주간 시작 요일 (1=월요일, 7=일요일)
  final int weekStartDay;

  /// 포커스 모드 사운드 활성화
  final bool focusSoundEnabled;

  /// 미완료 작업 자동 이월
  final bool autoRolloverEnabled;

  /// 연결된 캘린더 목록
  final List<String> connectedCalendars;

  const UserSettings({
    this.themeMode = ThemeMode.system,
    this.languageCode = 'ko',
    this.notificationsEnabled = true,
    this.notifyBeforeStartMinutes = 5,
    this.notifyBeforeEndMinutes = 5,
    this.dayStartHour = 6,
    this.dayEndHour = 24,
    this.defaultTimeBlockMinutes = 30,
    this.weekStartDay = 1,
    this.focusSoundEnabled = true,
    this.autoRolloverEnabled = true,
    this.connectedCalendars = const [],
  });

  /// 기본 설정
  static const UserSettings defaults = UserSettings();

  // TODO: copyWith, props (Equatable), toJson/fromJson 구현
}
