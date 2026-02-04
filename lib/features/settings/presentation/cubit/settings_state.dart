part of 'settings_cubit.dart';

/// 지원되는 언어 목록
const supportedLocales = [
  Locale('ko'), // 한국어
  Locale('en'), // 영어
  Locale('ja'), // 일본어
  Locale('hi'), // 힌디어
  Locale('zh'), // 중국어
  Locale('fr'), // 프랑스어
  Locale('de'), // 독일어
  Locale('ru'), // 러시아어
];

/// Settings 상태
class SettingsState extends Equatable {
  final ThemeMode themeMode;
  final Locale locale;
  final int defaultTimeBlockMinutes;
  final int dayStartHour;
  final int dayEndHour;

  // 알림 설정 (확장)
  final bool notificationsEnabled;
  final bool startAlarmEnabled;
  final bool endAlarmEnabled;
  final List<int> minutesBeforeStart;
  final List<int> minutesBeforeEnd;
  final bool dailyReminderEnabled;
  final int dailyReminderHour;
  final int dailyReminderMinute;
  final bool hasNotificationPermission;

  const SettingsState({
    this.themeMode = ThemeMode.system,
    this.locale = const Locale('ko'),
    this.defaultTimeBlockMinutes = 30,
    this.dayStartHour = 6,
    this.dayEndHour = 24,
    // 알림 설정 기본값
    this.notificationsEnabled = true,
    this.startAlarmEnabled = true,
    this.endAlarmEnabled = true,
    this.minutesBeforeStart = const [10],
    this.minutesBeforeEnd = const [10],
    this.dailyReminderEnabled = true,
    this.dailyReminderHour = 12,
    this.dailyReminderMinute = 0,
    this.hasNotificationPermission = false,
  });

  /// 테마 모드 표시 텍스트
  String get themeModeText {
    switch (themeMode) {
      case ThemeMode.system:
        return 'System';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }

  /// 언어 표시 텍스트
  String get localeText {
    switch (locale.languageCode) {
      case 'ko':
        return '한국어';
      case 'en':
        return 'English';
      case 'ja':
        return '日本語';
      case 'hi':
        return 'हिन्दी';
      case 'zh':
        return '中文';
      case 'fr':
        return 'Français';
      case 'de':
        return 'Deutsch';
      case 'ru':
        return 'Русский';
      default:
        return locale.languageCode;
    }
  }

  SettingsState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    int? defaultTimeBlockMinutes,
    int? dayStartHour,
    int? dayEndHour,
    bool? notificationsEnabled,
    bool? startAlarmEnabled,
    bool? endAlarmEnabled,
    List<int>? minutesBeforeStart,
    List<int>? minutesBeforeEnd,
    bool? dailyReminderEnabled,
    int? dailyReminderHour,
    int? dailyReminderMinute,
    bool? hasNotificationPermission,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      defaultTimeBlockMinutes:
          defaultTimeBlockMinutes ?? this.defaultTimeBlockMinutes,
      dayStartHour: dayStartHour ?? this.dayStartHour,
      dayEndHour: dayEndHour ?? this.dayEndHour,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      startAlarmEnabled: startAlarmEnabled ?? this.startAlarmEnabled,
      endAlarmEnabled: endAlarmEnabled ?? this.endAlarmEnabled,
      minutesBeforeStart: minutesBeforeStart ?? this.minutesBeforeStart,
      minutesBeforeEnd: minutesBeforeEnd ?? this.minutesBeforeEnd,
      dailyReminderEnabled: dailyReminderEnabled ?? this.dailyReminderEnabled,
      dailyReminderHour: dailyReminderHour ?? this.dailyReminderHour,
      dailyReminderMinute: dailyReminderMinute ?? this.dailyReminderMinute,
      hasNotificationPermission:
          hasNotificationPermission ?? this.hasNotificationPermission,
    );
  }

  @override
  List<Object?> get props => [
        themeMode,
        locale,
        defaultTimeBlockMinutes,
        dayStartHour,
        dayEndHour,
        notificationsEnabled,
        startAlarmEnabled,
        endAlarmEnabled,
        minutesBeforeStart,
        minutesBeforeEnd,
        dailyReminderEnabled,
        dailyReminderHour,
        dailyReminderMinute,
        hasNotificationPermission,
      ];
}
