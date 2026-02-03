import 'package:equatable/equatable.dart';

/// 인사이트 유형
enum InsightType {
  /// 집중 시간대 추천
  focusTime,

  /// 태그별 시간 추정 정확도
  tagAccuracy,

  /// 이월 경고
  rolloverWarning,

  /// 연속 달성 스트릭
  streak,

  /// 생산성 향상/하락
  productivityChange,

  /// 가장 생산적인 요일
  bestDay,

  /// 완료율 관련
  completionRate,

  /// 시간 절약
  timeSaved,

  /// Task 완료율
  taskCompletion,

  /// 집중 효율
  focusEfficiency,

  /// 시간 예측 정확도
  timeEstimation,
}

/// 인사이트 우선순위
enum InsightPriority {
  high,
  medium,
  low,
}

/// Insight 엔티티
///
/// 사용자에게 보여줄 인사이트 데이터
/// 키 기반 설계: titleKey + params로 프레젠테이션 레이어에서 번역
class Insight extends Equatable {
  /// 고유 ID
  final String id;

  /// 인사이트 유형
  final InsightType type;

  /// 우선순위
  final InsightPriority priority;

  /// 제목 키 (l10n용)
  final String titleKey;

  /// 설명 키 (l10n용, 옵션)
  final String? descriptionKey;

  /// 키 파라미터 (번역 시 치환용)
  final Map<String, String> params;

  /// 관련 수치 값
  final double? value;

  /// 수치 단위 키 (l10n용)
  final String? unitKey;

  /// 아이콘 코드 포인트
  final int iconCodePoint;

  /// 긍정적인 인사이트인지 여부
  final bool isPositive;

  /// 관련 날짜
  final DateTime? relatedDate;

  /// 관련 태그 이름
  final String? relatedTag;

  /// 생성 시간
  final DateTime createdAt;

  const Insight({
    required this.id,
    required this.type,
    required this.priority,
    required this.titleKey,
    this.descriptionKey,
    this.params = const {},
    this.value,
    this.unitKey,
    required this.iconCodePoint,
    required this.isPositive,
    this.relatedDate,
    this.relatedTag,
    required this.createdAt,
  });

  /// 집중 시간대 인사이트 생성
  factory Insight.focusTime({
    required String id,
    required String dayName,
    required int hour,
  }) {
    return Insight(
      id: id,
      type: InsightType.focusTime,
      priority: InsightPriority.high,
      titleKey: 'insightFocusTimeTitle',
      descriptionKey: 'insightFocusTimeDesc',
      params: {'dayName': dayName, 'hour': '$hour'},
      iconCodePoint: 0xe8b5,
      isPositive: true,
      createdAt: DateTime.now(),
    );
  }

  /// 태그별 정확도 인사이트 생성
  factory Insight.tagAccuracy({
    required String id,
    required String tagName,
    required int minutesDiff,
    required bool isFaster,
  }) {
    return Insight(
      id: id,
      type: InsightType.tagAccuracy,
      priority: InsightPriority.medium,
      titleKey: isFaster ? 'insightTagAccuracyFasterTitle' : 'insightTagAccuracySlowerTitle',
      descriptionKey: isFaster ? 'insightTagAccuracyFasterDesc' : 'insightTagAccuracySlowerDesc',
      params: {'tagName': tagName, 'minutes': '${minutesDiff.abs()}'},
      value: minutesDiff.toDouble(),
      unitKey: 'minutes',
      iconCodePoint: 0xe8b8,
      isPositive: isFaster,
      relatedTag: tagName,
      createdAt: DateTime.now(),
    );
  }

  /// 이월 경고 인사이트 생성
  factory Insight.rolloverWarning({
    required String id,
    required int rolloverCount,
    required int taskCount,
  }) {
    return Insight(
      id: id,
      type: InsightType.rolloverWarning,
      priority: InsightPriority.high,
      titleKey: 'insightRolloverTitle',
      descriptionKey: 'insightRolloverDesc',
      params: {'rolloverCount': '$rolloverCount', 'taskCount': '$taskCount'},
      value: taskCount.toDouble(),
      unitKey: 'insightUnitCount',
      iconCodePoint: 0xe002,
      isPositive: false,
      createdAt: DateTime.now(),
    );
  }

  /// 연속 달성 스트릭 인사이트 생성
  factory Insight.streak({
    required String id,
    required int days,
  }) {
    return Insight(
      id: id,
      type: InsightType.streak,
      priority: InsightPriority.high,
      titleKey: 'insightStreakTitle',
      descriptionKey: 'insightStreakDesc',
      params: {'days': '$days'},
      value: days.toDouble(),
      unitKey: 'insightUnitDays',
      iconCodePoint: 0xf06bb,
      isPositive: true,
      createdAt: DateTime.now(),
    );
  }

  /// 생산성 변화 인사이트 생성
  factory Insight.productivityChange({
    required String id,
    required int scoreDiff,
    required String periodKey,
  }) {
    final isImproved = scoreDiff > 0;
    return Insight(
      id: id,
      type: InsightType.productivityChange,
      priority: InsightPriority.medium,
      titleKey: isImproved ? 'insightScoreUpTitle' : 'insightScoreDownTitle',
      descriptionKey: isImproved ? 'insightScoreUpDesc' : 'insightScoreDownDesc',
      params: {'scoreDiff': '${scoreDiff.abs()}', 'period': periodKey},
      value: scoreDiff.toDouble(),
      unitKey: 'insightUnitPoints',
      iconCodePoint: isImproved ? 0xe5d8 : 0xe5db,
      isPositive: isImproved,
      createdAt: DateTime.now(),
    );
  }

  /// 가장 생산적인 요일 인사이트 생성
  factory Insight.bestDay({
    required String id,
    required String dayKey,
    required double avgScore,
  }) {
    return Insight(
      id: id,
      type: InsightType.bestDay,
      priority: InsightPriority.medium,
      titleKey: 'insightBestDayTitle',
      descriptionKey: 'insightBestDayDesc',
      params: {'dayName': dayKey, 'score': avgScore.toStringAsFixed(0)},
      value: avgScore,
      unitKey: 'insightUnitPoints',
      iconCodePoint: 0xe838,
      isPositive: true,
      createdAt: DateTime.now(),
    );
  }

  /// 시간 절약 인사이트 생성
  factory Insight.timeSaved({
    required String id,
    required int minutesSaved,
    required String periodKey,
  }) {
    return Insight(
      id: id,
      type: InsightType.timeSaved,
      priority: InsightPriority.medium,
      titleKey: 'insightTimeSavedTitle',
      descriptionKey: 'insightTimeSavedDesc',
      params: {'minutes': '$minutesSaved', 'period': periodKey},
      value: minutesSaved.toDouble(),
      unitKey: 'minutes',
      iconCodePoint: 0xe425,
      isPositive: true,
      createdAt: DateTime.now(),
    );
  }

  /// 시간 초과 인사이트 생성
  factory Insight.timeOver({
    required String id,
    required int minutesOver,
    required String periodKey,
  }) {
    return Insight(
      id: id,
      type: InsightType.timeSaved,
      priority: InsightPriority.medium,
      titleKey: 'insightTimeOverTitle',
      descriptionKey: 'insightTimeOverDesc',
      params: {'minutes': '$minutesOver', 'period': periodKey},
      value: minutesOver.toDouble(),
      unitKey: 'minutes',
      iconCodePoint: 0xe425,
      isPositive: false,
      createdAt: DateTime.now(),
    );
  }

  /// Task 완료율 인사이트 생성
  factory Insight.taskCompletion({
    required String id,
    required int completed,
    required int total,
  }) {
    final String titleKey;
    final String descKey;
    final bool isPositive;

    if (total == 0) {
      titleKey = 'insightTaskFirstTitle';
      descKey = 'insightTaskFirstDesc';
      isPositive = true;
    } else if (completed == total) {
      titleKey = 'insightTaskAllCompleteTitle';
      descKey = 'insightTaskAllCompleteDesc';
      isPositive = true;
    } else if (completed == 0) {
      titleKey = 'insightTaskNoneTitle';
      descKey = 'insightTaskNoneDesc';
      isPositive = false;
    } else {
      titleKey = 'insightTaskPartialTitle';
      descKey = 'insightTaskPartialDesc';
      isPositive = completed >= total / 2;
    }

    return Insight(
      id: id,
      type: InsightType.taskCompletion,
      priority: InsightPriority.high,
      titleKey: titleKey,
      descriptionKey: descKey,
      params: {
        'completed': '$completed',
        'total': '$total',
        'remaining': '${total - completed}',
      },
      value: total > 0 ? (completed / total * 100) : 0,
      unitKey: 'insightUnitPercent',
      iconCodePoint: 0xef6b,
      isPositive: isPositive,
      createdAt: DateTime.now(),
    );
  }

  /// 집중 효율 인사이트 생성
  factory Insight.focusEfficiency({
    required String id,
    required int efficiencyPercent,
    required int focusMinutes,
  }) {
    final String descKey;
    if (efficiencyPercent >= 90) {
      descKey = 'insightFocusEffHighDesc';
    } else if (efficiencyPercent >= 70) {
      descKey = 'insightFocusEffMedDesc';
    } else {
      descKey = 'insightFocusEffLowDesc';
    }

    return Insight(
      id: id,
      type: InsightType.focusEfficiency,
      priority: InsightPriority.medium,
      titleKey: 'insightFocusEffTitle',
      descriptionKey: descKey,
      params: {'percent': '$efficiencyPercent'},
      value: efficiencyPercent.toDouble(),
      unitKey: 'insightUnitPercent',
      iconCodePoint: 0xe4a2,
      isPositive: efficiencyPercent >= 70,
      createdAt: DateTime.now(),
    );
  }

  /// 시간 예측 정확도 인사이트 생성
  factory Insight.timeEstimation({
    required String id,
    required int accuracyPercent,
  }) {
    final String descKey;
    if (accuracyPercent >= 90) {
      descKey = 'insightTimeEstHighDesc';
    } else if (accuracyPercent >= 70) {
      descKey = 'insightTimeEstMedDesc';
    } else {
      descKey = 'insightTimeEstLowDesc';
    }

    return Insight(
      id: id,
      type: InsightType.timeEstimation,
      priority: InsightPriority.medium,
      titleKey: 'insightTimeEstTitle',
      descriptionKey: descKey,
      params: {'percent': '$accuracyPercent'},
      value: accuracyPercent.toDouble(),
      unitKey: 'insightUnitPercent',
      iconCodePoint: 0xe1b1,
      isPositive: accuracyPercent >= 70,
      createdAt: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        type,
        priority,
        titleKey,
        descriptionKey,
        params,
        value,
        unitKey,
        iconCodePoint,
        isPositive,
        relatedDate,
        relatedTag,
        createdAt,
      ];
}
