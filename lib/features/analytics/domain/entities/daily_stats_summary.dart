import 'package:equatable/equatable.dart';

/// DailyStatsSummary 엔티티
///
/// 일별 통계 요약 데이터 (저장용)
/// 매일 자정에 집계되어 Hive에 저장됨
class DailyStatsSummary extends Equatable {
  /// 고유 ID (date를 기반으로 생성)
  final String id;

  /// 날짜 (자정으로 정규화)
  final DateTime date;

  // Task 통계
  /// 계획한 Task 수
  final int totalPlannedTasks;

  /// 완료한 Task 수
  final int completedTasks;

  /// 이월된 Task 수 (이전에서 넘어온)
  final int rolledOverTasks;

  // TimeBlock 통계
  /// 총 TimeBlock 수
  final int totalTimeBlocks;

  /// 완료한 TimeBlock 수
  final int completedTimeBlocks;

  /// 총 계획 시간
  final Duration totalPlannedDuration;

  /// 총 실제 작업 시간
  final Duration totalActualDuration;

  // Focus 통계
  /// 집중 세션 수
  final int focusSessionCount;

  /// 총 집중 시간
  final Duration totalFocusDuration;

  /// 총 일시정지 시간
  final Duration totalPauseDuration;

  // Top 3 달성
  /// Top 3 중 완료한 수 (0~3)
  final int top3CompletedCount;

  // 생산성 점수
  /// 종합 생산성 점수 (0~100)
  final int productivityScore;

  // 메타데이터
  /// 집계 시간
  final DateTime calculatedAt;

  const DailyStatsSummary({
    required this.id,
    required this.date,
    required this.totalPlannedTasks,
    required this.completedTasks,
    required this.rolledOverTasks,
    required this.totalTimeBlocks,
    required this.completedTimeBlocks,
    required this.totalPlannedDuration,
    required this.totalActualDuration,
    required this.focusSessionCount,
    required this.totalFocusDuration,
    required this.totalPauseDuration,
    required this.top3CompletedCount,
    required this.productivityScore,
    required this.calculatedAt,
  });

  /// 날짜 키 (yyyy-MM-dd)
  String get dateKey {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Task 완료율 (%)
  double get taskCompletionRate {
    if (totalPlannedTasks == 0) return 100.0;
    return (completedTasks / totalPlannedTasks) * 100;
  }

  /// TimeBlock 완료율 (%)
  double get timeBlockCompletionRate {
    if (totalTimeBlocks == 0) return 100.0;
    return (completedTimeBlocks / totalTimeBlocks) * 100;
  }

  /// 시간 정확도 (%)
  double get timeAccuracy {
    if (totalPlannedDuration.inMinutes == 0) return 100.0;
    final diff = (totalActualDuration - totalPlannedDuration).inMinutes.abs();
    final ratio = diff / totalPlannedDuration.inMinutes;
    return ((1 - ratio) * 100).clamp(0.0, 100.0);
  }

  /// 집중 효율 (%)
  double get focusEfficiency {
    final totalTime = totalFocusDuration + totalPauseDuration;
    if (totalTime.inMinutes == 0) return 100.0;
    return (totalFocusDuration.inMinutes / totalTime.inMinutes) * 100;
  }

  /// Top 3 달성률 (%)
  double get top3CompletionRate {
    return (top3CompletedCount / 3) * 100;
  }

  /// 시간 절약/초과 (분)
  int get timeDifferenceMinutes {
    return totalPlannedDuration.inMinutes - totalActualDuration.inMinutes;
  }

  /// 빈 통계 생성
  factory DailyStatsSummary.empty(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    return DailyStatsSummary(
      id: 'stats_${normalizedDate.toIso8601String()}',
      date: normalizedDate,
      totalPlannedTasks: 0,
      completedTasks: 0,
      rolledOverTasks: 0,
      totalTimeBlocks: 0,
      completedTimeBlocks: 0,
      totalPlannedDuration: Duration.zero,
      totalActualDuration: Duration.zero,
      focusSessionCount: 0,
      totalFocusDuration: Duration.zero,
      totalPauseDuration: Duration.zero,
      top3CompletedCount: 0,
      productivityScore: 0,
      calculatedAt: DateTime.now(),
    );
  }

  DailyStatsSummary copyWith({
    String? id,
    DateTime? date,
    int? totalPlannedTasks,
    int? completedTasks,
    int? rolledOverTasks,
    int? totalTimeBlocks,
    int? completedTimeBlocks,
    Duration? totalPlannedDuration,
    Duration? totalActualDuration,
    int? focusSessionCount,
    Duration? totalFocusDuration,
    Duration? totalPauseDuration,
    int? top3CompletedCount,
    int? productivityScore,
    DateTime? calculatedAt,
  }) {
    return DailyStatsSummary(
      id: id ?? this.id,
      date: date ?? this.date,
      totalPlannedTasks: totalPlannedTasks ?? this.totalPlannedTasks,
      completedTasks: completedTasks ?? this.completedTasks,
      rolledOverTasks: rolledOverTasks ?? this.rolledOverTasks,
      totalTimeBlocks: totalTimeBlocks ?? this.totalTimeBlocks,
      completedTimeBlocks: completedTimeBlocks ?? this.completedTimeBlocks,
      totalPlannedDuration: totalPlannedDuration ?? this.totalPlannedDuration,
      totalActualDuration: totalActualDuration ?? this.totalActualDuration,
      focusSessionCount: focusSessionCount ?? this.focusSessionCount,
      totalFocusDuration: totalFocusDuration ?? this.totalFocusDuration,
      totalPauseDuration: totalPauseDuration ?? this.totalPauseDuration,
      top3CompletedCount: top3CompletedCount ?? this.top3CompletedCount,
      productivityScore: productivityScore ?? this.productivityScore,
      calculatedAt: calculatedAt ?? this.calculatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        date,
        totalPlannedTasks,
        completedTasks,
        rolledOverTasks,
        totalTimeBlocks,
        completedTimeBlocks,
        totalPlannedDuration,
        totalActualDuration,
        focusSessionCount,
        totalFocusDuration,
        totalPauseDuration,
        top3CompletedCount,
        productivityScore,
        calculatedAt,
      ];
}
