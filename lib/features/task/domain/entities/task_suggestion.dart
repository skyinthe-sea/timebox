/// Task 자동완성 제안 엔티티
///
/// 브레인 덤프 입력 시 과거 이력 기반 제안
class TaskSuggestion {
  /// 제안 제목 (정규화된 형태)
  final String title;

  /// 종합 점수 (0.0 ~ 1.0)
  final double score;

  /// 동일 제목 생성 빈도
  final int frequency;

  /// 마지막 사용 시각
  final DateTime lastUsedAt;

  /// 평균 예상 소요 시간
  final Duration avgEstimatedDuration;

  const TaskSuggestion({
    required this.title,
    required this.score,
    required this.frequency,
    required this.lastUsedAt,
    required this.avgEstimatedDuration,
  });
}
