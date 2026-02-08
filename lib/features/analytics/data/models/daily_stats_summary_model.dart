import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/daily_stats_summary.dart';

part 'daily_stats_summary_model.freezed.dart';
part 'daily_stats_summary_model.g.dart';

/// DailyStatsSummary 데이터 모델
///
/// Hive 저장 및 JSON 직렬화를 위한 모델
@freezed
class DailyStatsSummaryModel with _$DailyStatsSummaryModel {
  const DailyStatsSummaryModel._();

  const factory DailyStatsSummaryModel({
    required String id,
    required DateTime date,

    // Task 통계
    required int totalPlannedTasks,
    required int completedTasks,
    @Default(0) int rolledOverTasks,

    // TimeBlock 통계
    required int totalTimeBlocks,
    required int completedTimeBlocks,
    required int totalPlannedDurationMinutes,
    required int totalActualDurationMinutes,

    // Focus 통계
    @Default(0) int focusSessionCount,
    @Default(0) int totalFocusDurationMinutes,
    @Default(0) int totalPauseDurationMinutes,

    // Top 3 달성
    @Default(0) int top3SetCount,
    @Default(0) int top3CompletedCount,

    // 시간 정확도 (블록별 평균, -1 = 데이터 없음)
    @Default(-1.0) double timeAccuracyPercent,

    // 생산성 점수
    required int productivityScore,

    // 메타데이터
    required DateTime calculatedAt,
  }) = _DailyStatsSummaryModel;

  factory DailyStatsSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$DailyStatsSummaryModelFromJson(json);

  /// Domain Entity로 변환
  DailyStatsSummary toEntity() {
    return DailyStatsSummary(
      id: id,
      date: date,
      totalPlannedTasks: totalPlannedTasks,
      completedTasks: completedTasks,
      rolledOverTasks: rolledOverTasks,
      totalTimeBlocks: totalTimeBlocks,
      completedTimeBlocks: completedTimeBlocks,
      totalPlannedDuration: Duration(minutes: totalPlannedDurationMinutes),
      totalActualDuration: Duration(minutes: totalActualDurationMinutes),
      focusSessionCount: focusSessionCount,
      totalFocusDuration: Duration(minutes: totalFocusDurationMinutes),
      totalPauseDuration: Duration(minutes: totalPauseDurationMinutes),
      top3SetCount: top3SetCount,
      top3CompletedCount: top3CompletedCount,
      timeAccuracyPercent: timeAccuracyPercent,
      productivityScore: productivityScore,
      calculatedAt: calculatedAt,
    );
  }

  /// Domain Entity에서 생성
  factory DailyStatsSummaryModel.fromEntity(DailyStatsSummary entity) {
    return DailyStatsSummaryModel(
      id: entity.id,
      date: entity.date,
      totalPlannedTasks: entity.totalPlannedTasks,
      completedTasks: entity.completedTasks,
      rolledOverTasks: entity.rolledOverTasks,
      totalTimeBlocks: entity.totalTimeBlocks,
      completedTimeBlocks: entity.completedTimeBlocks,
      totalPlannedDurationMinutes: entity.totalPlannedDuration.inMinutes,
      totalActualDurationMinutes: entity.totalActualDuration.inMinutes,
      focusSessionCount: entity.focusSessionCount,
      totalFocusDurationMinutes: entity.totalFocusDuration.inMinutes,
      totalPauseDurationMinutes: entity.totalPauseDuration.inMinutes,
      top3SetCount: entity.top3SetCount,
      top3CompletedCount: entity.top3CompletedCount,
      timeAccuracyPercent: entity.timeAccuracyPercent,
      productivityScore: entity.productivityScore,
      calculatedAt: entity.calculatedAt,
    );
  }

  /// 날짜 키 생성 (yyyy-MM-dd 형식)
  String get dateKey {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
