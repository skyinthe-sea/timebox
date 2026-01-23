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
/// AI 코칭 스타일 + 통계 스타일 혼합
class Insight extends Equatable {
  /// 고유 ID
  final String id;

  /// 인사이트 유형
  final InsightType type;

  /// 우선순위
  final InsightPriority priority;

  /// 제목 (AI 코칭 스타일)
  final String title;

  /// 상세 설명 (옵션)
  final String? description;

  /// 관련 수치 값
  final double? value;

  /// 수치 단위 (예: "분", "%", "회")
  final String? unit;

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
    required this.title,
    this.description,
    this.value,
    this.unit,
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
      title: '$dayName ${hour}시에 가장 집중력이 높아요!',
      description: '이 시간대에 중요한 작업을 배치해보세요.',
      iconCodePoint: 0xe8b5, // Icons.lightbulb_outline
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
    final diffText = isFaster ? '빨리' : '늦게';
    return Insight(
      id: id,
      type: InsightType.tagAccuracy,
      priority: InsightPriority.medium,
      title: '$tagName Task는 예상보다 평균 ${minutesDiff.abs()}분 $diffText 끝나요',
      description: isFaster ? '예상 시간을 조금 줄여도 괜찮아요.' : '여유 시간을 더 두는 게 좋겠어요.',
      value: minutesDiff.toDouble(),
      unit: '분',
      iconCodePoint: 0xe8b8, // Icons.schedule
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
      title: '${rolloverCount}번 이상 이월된 Task가 ${taskCount}개 있어요',
      description: '작게 쪼개거나 우선순위를 조정해보세요.',
      value: taskCount.toDouble(),
      unit: '개',
      iconCodePoint: 0xe002, // Icons.warning_amber
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
      title: '연속 $days일 목표를 달성했어요!',
      description: '대단해요! 이 기세를 유지해보세요.',
      value: days.toDouble(),
      unit: '일',
      iconCodePoint: 0xf06bb, // Icons.local_fire_department
      isPositive: true,
      createdAt: DateTime.now(),
    );
  }

  /// 생산성 변화 인사이트 생성
  factory Insight.productivityChange({
    required String id,
    required int scoreDiff,
    required String periodText,
  }) {
    final isImproved = scoreDiff > 0;
    final changeText = isImproved ? '상승' : '하락';
    return Insight(
      id: id,
      type: InsightType.productivityChange,
      priority: InsightPriority.medium,
      title: '$periodText 대비 ${scoreDiff.abs()}점 $changeText했어요',
      description: isImproved ? '좋은 흐름이에요!' : '조금 더 집중해볼까요?',
      value: scoreDiff.toDouble(),
      unit: '점',
      iconCodePoint: isImproved ? 0xe5d8 : 0xe5db, // Icons.trending_up/down
      isPositive: isImproved,
      createdAt: DateTime.now(),
    );
  }

  /// 가장 생산적인 요일 인사이트 생성
  factory Insight.bestDay({
    required String id,
    required String dayName,
    required double avgScore,
  }) {
    return Insight(
      id: id,
      type: InsightType.bestDay,
      priority: InsightPriority.medium,
      title: '${dayName}이 가장 생산적인 요일이에요',
      description: '평균 생산성 점수 ${avgScore.toStringAsFixed(0)}점',
      value: avgScore,
      unit: '점',
      iconCodePoint: 0xe838, // Icons.star
      isPositive: true,
      createdAt: DateTime.now(),
    );
  }

  /// 시간 절약 인사이트 생성
  factory Insight.timeSaved({
    required String id,
    required int minutesSaved,
    required String periodText,
  }) {
    return Insight(
      id: id,
      type: InsightType.timeSaved,
      priority: InsightPriority.medium,
      title: '$periodText 총 $minutesSaved분을 절약했어요',
      description: '효율적으로 일하고 있네요!',
      value: minutesSaved.toDouble(),
      unit: '분',
      iconCodePoint: 0xe425, // Icons.timer
      isPositive: true,
      createdAt: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        type,
        priority,
        title,
        description,
        value,
        unit,
        iconCodePoint,
        isPositive,
        relatedDate,
        relatedTag,
        createdAt,
      ];
}
