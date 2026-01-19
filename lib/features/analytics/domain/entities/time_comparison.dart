/// TimeComparison 엔티티
///
/// 계획 시간 vs 실제 시간 비교 데이터
///
/// 개별 TimeBlock 또는 집계된 비교 데이터
class TimeComparison {
  /// TimeBlock 또는 Task ID
  final String id;

  /// 제목
  final String title;

  /// 계획된 시간
  final Duration plannedDuration;

  /// 실제 소요 시간
  final Duration actualDuration;

  /// 날짜
  final DateTime date;

  /// 태그 (선택)
  final String? tag;

  const TimeComparison({
    required this.id,
    required this.title,
    required this.plannedDuration,
    required this.actualDuration,
    required this.date,
    this.tag,
  });

  /// 시간 차이 (실제 - 계획)
  Duration get difference => actualDuration - plannedDuration;

  /// 오차율 (%)
  double get differencePercentage {
    if (plannedDuration.inMinutes == 0) return 0.0;
    return (difference.inMinutes / plannedDuration.inMinutes) * 100;
  }

  /// 예상보다 빨리 끝났는지 여부
  bool get isUnderEstimated => difference.isNegative;

  /// 예상보다 늦게 끝났는지 여부
  bool get isOverEstimated => !difference.isNegative && difference.inMinutes > 0;

  /// 정확했는지 여부 (5분 이내 오차)
  bool get isAccurate => difference.inMinutes.abs() <= 5;

  // TODO: copyWith, props (Equatable), toJson/fromJson 구현
}

/// 태그별 시간 비교 집계
class TagTimeComparison {
  /// 태그 이름
  final String tagName;

  /// 태그 색상
  final int colorValue;

  /// 해당 태그의 총 계획 시간
  final Duration totalPlannedTime;

  /// 해당 태그의 총 실제 시간
  final Duration totalActualTime;

  /// 해당 태그의 Task 수
  final int taskCount;

  const TagTimeComparison({
    required this.tagName,
    required this.colorValue,
    required this.totalPlannedTime,
    required this.totalActualTime,
    required this.taskCount,
  });

  /// 평균 오차
  Duration get averageDifference {
    if (taskCount == 0) return Duration.zero;
    final totalDiff = totalActualTime - totalPlannedTime;
    return Duration(minutes: totalDiff.inMinutes ~/ taskCount);
  }
}
