/// 시간 프리셋
///
/// 타임박스 예상 소요 시간 선택에 사용되는 프리셋 값들
abstract class DurationPresets {
  /// 빠른 작업 (15분)
  static const Duration quick = Duration(minutes: 15);

  /// 짧은 작업 (30분)
  static const Duration short = Duration(minutes: 30);

  /// 보통 작업 (45분)
  static const Duration medium = Duration(minutes: 45);

  /// 표준 작업 (1시간)
  static const Duration standard = Duration(hours: 1);

  /// 긴 작업 (1시간 30분)
  static const Duration long = Duration(hours: 1, minutes: 30);

  /// 집중 작업 (2시간)
  static const Duration focused = Duration(hours: 2);

  /// 반나절 (4시간)
  static const Duration halfDay = Duration(hours: 4);

  /// 모든 프리셋 목록
  static const List<Duration> all = [
    quick,
    short,
    medium,
    standard,
    long,
    focused,
    halfDay,
  ];

  /// 프리셋 라벨 (다국어 키로 대체 예정)
  static String getLabel(Duration duration) {
    // TODO: 다국어 지원으로 변경
    final minutes = duration.inMinutes;
    if (minutes < 60) {
      return '$minutes분';
    } else {
      final hours = minutes ~/ 60;
      final remainingMinutes = minutes % 60;
      if (remainingMinutes == 0) {
        return '$hours시간';
      }
      return '$hours시간 $remainingMinutes분';
    }
  }
}
