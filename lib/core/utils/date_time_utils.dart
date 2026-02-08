import '../../../l10n/app_localizations.dart';

/// 날짜/시간 유틸리티
///
/// 날짜와 시간 관련 헬퍼 함수 모음
abstract class DateTimeUtils {
  /// 오늘 날짜의 시작 시간 (00:00:00)
  static DateTime startOfDay([DateTime? date]) {
    final d = date ?? DateTime.now();
    return DateTime(d.year, d.month, d.day);
  }

  /// 오늘 날짜의 종료 시간 (23:59:59)
  static DateTime endOfDay([DateTime? date]) {
    final d = date ?? DateTime.now();
    return DateTime(d.year, d.month, d.day, 23, 59, 59, 999);
  }

  /// 이번 주의 시작일 (월요일)
  static DateTime startOfWeek([DateTime? date]) {
    final d = date ?? DateTime.now();
    final daysToSubtract = d.weekday - 1;
    return startOfDay(d.subtract(Duration(days: daysToSubtract)));
  }

  /// 이번 주의 종료일 (일요일)
  static DateTime endOfWeek([DateTime? date]) {
    final d = date ?? DateTime.now();
    final daysToAdd = 7 - d.weekday;
    return endOfDay(d.add(Duration(days: daysToAdd)));
  }

  /// 같은 날인지 확인
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// 오늘인지 확인
  static bool isToday(DateTime date) {
    return isSameDay(date, DateTime.now());
  }

  /// 두 시간 범위가 겹치는지 확인
  static bool isOverlapping({
    required DateTime start1,
    required DateTime end1,
    required DateTime start2,
    required DateTime end2,
  }) {
    return start1.isBefore(end2) && end1.isAfter(start2);
  }

  /// 시간을 가장 가까운 분 단위로 반올림
  /// [minuteInterval]: 반올림 단위 (예: 15분)
  static DateTime roundToNearestMinutes(DateTime time, int minuteInterval) {
    final minutes = time.minute;
    final roundedMinutes =
        (minutes / minuteInterval).round() * minuteInterval;
    return DateTime(
      time.year,
      time.month,
      time.day,
      time.hour + (roundedMinutes ~/ 60),
      roundedMinutes % 60,
    );
  }

  /// Duration을 사람이 읽기 쉬운 형식으로 변환
  /// 예: "1시간 30분", "45분"
  static String formatDuration(Duration duration, AppLocalizations l10n) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    if (hours > 0 && minutes > 0) {
      return l10n.durationFormat(hours, minutes);
    } else if (hours > 0) {
      return l10n.hoursShort(hours);
    } else {
      return l10n.minutesShort(minutes);
    }
  }
}
