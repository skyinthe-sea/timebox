/// 개별 우선순위 통계
class PriorityStat {
  final int total;
  final int completed;

  const PriorityStat({
    required this.total,
    required this.completed,
  });

  /// 완료율 (%)
  double get completionRate => total > 0 ? completed / total * 100 : 0;

  static const empty = PriorityStat(total: 0, completed: 0);
}

/// 우선순위별 성과 통계
class PriorityBreakdownStats {
  final PriorityStat high;
  final PriorityStat medium;
  final PriorityStat low;

  const PriorityBreakdownStats({
    required this.high,
    required this.medium,
    required this.low,
  });

  static const empty = PriorityBreakdownStats(
    high: PriorityStat.empty,
    medium: PriorityStat.empty,
    low: PriorityStat.empty,
  );
}
