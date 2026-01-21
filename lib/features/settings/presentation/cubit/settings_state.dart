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
];

/// Settings 상태
class SettingsState extends Equatable {
  final ThemeMode themeMode;
  final Locale locale;
  final bool notificationsEnabled;
  final int notificationBeforeMinutes;
  final int defaultTimeBlockMinutes;
  final int dayStartHour;
  final int dayEndHour;

  const SettingsState({
    this.themeMode = ThemeMode.system,
    this.locale = const Locale('ko'),
    this.notificationsEnabled = true,
    this.notificationBeforeMinutes = 5,
    this.defaultTimeBlockMinutes = 30,
    this.dayStartHour = 6,
    this.dayEndHour = 24,
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
      default:
        return locale.languageCode;
    }
  }

  SettingsState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    bool? notificationsEnabled,
    int? notificationBeforeMinutes,
    int? defaultTimeBlockMinutes,
    int? dayStartHour,
    int? dayEndHour,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      notificationBeforeMinutes:
          notificationBeforeMinutes ?? this.notificationBeforeMinutes,
      defaultTimeBlockMinutes:
          defaultTimeBlockMinutes ?? this.defaultTimeBlockMinutes,
      dayStartHour: dayStartHour ?? this.dayStartHour,
      dayEndHour: dayEndHour ?? this.dayEndHour,
    );
  }

  @override
  List<Object?> get props => [
        themeMode,
        locale,
        notificationsEnabled,
        notificationBeforeMinutes,
        defaultTimeBlockMinutes,
        dayStartHour,
        dayEndHour,
      ];
}
