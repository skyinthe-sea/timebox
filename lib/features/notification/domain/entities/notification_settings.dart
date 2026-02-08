import 'package:equatable/equatable.dart';

/// 알림 설정 엔티티
///
/// 사용자의 알림 관련 설정을 저장
class NotificationSettings extends Equatable {
  /// 알림 마스터 토글 (전체 on/off)
  final bool enabled;

  /// 시작 알림 활성화 여부
  final bool startAlarmEnabled;

  /// 종료 알림 활성화 여부
  final bool endAlarmEnabled;

  /// 시작 전 알림 시간 목록 (분 단위, 다중 선택)
  /// 예: [10, 30] = 10분 전, 30분 전 둘 다 알림
  final List<int> minutesBeforeStart;

  /// 종료 전 알림 시간 목록 (분 단위, 다중 선택)
  final List<int> minutesBeforeEnd;

  /// 일일 리마인더 활성화 여부
  final bool dailyReminderEnabled;

  /// 일일 리마인더 시간 (시)
  final int dailyReminderHour;

  /// 일일 리마인더 시간 (분)
  final int dailyReminderMinute;

  /// 사용 가능한 타이밍 옵션 (분)
  static const List<int> availableTimingOptions = [5, 10, 15, 30, 60];

  const NotificationSettings({
    this.enabled = true,
    this.startAlarmEnabled = true,
    this.endAlarmEnabled = true,
    this.minutesBeforeStart = const [10],
    this.minutesBeforeEnd = const [10],
    this.dailyReminderEnabled = true,
    this.dailyReminderHour = 12,
    this.dailyReminderMinute = 0,
  });

  /// 기본값으로 생성
  factory NotificationSettings.defaults() => const NotificationSettings();

  /// 분 단위를 표시 문자열로 변환
  static String formatMinutes(int minutes, {String Function(int)? hoursFormatter, String Function(int)? minutesFormatter}) {
    final hFmt = hoursFormatter ?? (h) => '${h}h';
    final mFmt = minutesFormatter ?? (m) => '${m}m';
    if (minutes >= 60) {
      final hours = minutes ~/ 60;
      return hFmt(hours);
    }
    return mFmt(minutes);
  }

  NotificationSettings copyWith({
    bool? enabled,
    bool? startAlarmEnabled,
    bool? endAlarmEnabled,
    List<int>? minutesBeforeStart,
    List<int>? minutesBeforeEnd,
    bool? dailyReminderEnabled,
    int? dailyReminderHour,
    int? dailyReminderMinute,
  }) {
    return NotificationSettings(
      enabled: enabled ?? this.enabled,
      startAlarmEnabled: startAlarmEnabled ?? this.startAlarmEnabled,
      endAlarmEnabled: endAlarmEnabled ?? this.endAlarmEnabled,
      minutesBeforeStart: minutesBeforeStart ?? this.minutesBeforeStart,
      minutesBeforeEnd: minutesBeforeEnd ?? this.minutesBeforeEnd,
      dailyReminderEnabled: dailyReminderEnabled ?? this.dailyReminderEnabled,
      dailyReminderHour: dailyReminderHour ?? this.dailyReminderHour,
      dailyReminderMinute: dailyReminderMinute ?? this.dailyReminderMinute,
    );
  }

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'startAlarmEnabled': startAlarmEnabled,
        'endAlarmEnabled': endAlarmEnabled,
        'minutesBeforeStart': minutesBeforeStart,
        'minutesBeforeEnd': minutesBeforeEnd,
        'dailyReminderEnabled': dailyReminderEnabled,
        'dailyReminderHour': dailyReminderHour,
        'dailyReminderMinute': dailyReminderMinute,
      };

  factory NotificationSettings.fromJson(Map<String, dynamic> json) {
    return NotificationSettings(
      enabled: json['enabled'] as bool? ?? true,
      startAlarmEnabled: json['startAlarmEnabled'] as bool? ?? true,
      endAlarmEnabled: json['endAlarmEnabled'] as bool? ?? true,
      minutesBeforeStart: (json['minutesBeforeStart'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [10],
      minutesBeforeEnd: (json['minutesBeforeEnd'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [10],
      dailyReminderEnabled: json['dailyReminderEnabled'] as bool? ?? true,
      dailyReminderHour: json['dailyReminderHour'] as int? ?? 12,
      dailyReminderMinute: json['dailyReminderMinute'] as int? ?? 0,
    );
  }

  @override
  List<Object?> get props => [
        enabled,
        startAlarmEnabled,
        endAlarmEnabled,
        minutesBeforeStart,
        minutesBeforeEnd,
        dailyReminderEnabled,
        dailyReminderHour,
        dailyReminderMinute,
      ];
}
