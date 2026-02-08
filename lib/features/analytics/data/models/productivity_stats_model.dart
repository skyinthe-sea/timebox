import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/productivity_stats.dart';

part 'productivity_stats_model.freezed.dart';
part 'productivity_stats_model.g.dart';

/// ProductivityStats 데이터 모델
///
/// Hive 저장 및 JSON 직렬화를 위한 모델
@freezed
class ProductivityStatsModel with _$ProductivityStatsModel {
  const ProductivityStatsModel._();

  const factory ProductivityStatsModel({
    required DateTime date,
    required int score,
    required int completedTasks,
    required int totalPlannedTasks,
    required int completedTimeBlocks,
    @Default(0) int skippedTimeBlocks,
    required int totalPlannedTimeBlocks,
    required double executionRate,
    required int totalPlannedTimeMinutes,
    required int totalActualTimeMinutes,
    required int focusTimeMinutes,
    required int averageTimeDifferenceMinutes,
    @Default(-1.0) double timeAccuracyPercent,
  }) = _ProductivityStatsModel;

  factory ProductivityStatsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductivityStatsModelFromJson(json);

  /// Domain Entity로 변환
  ProductivityStats toEntity() {
    return ProductivityStats(
      date: date,
      score: score,
      completedTasks: completedTasks,
      totalPlannedTasks: totalPlannedTasks,
      completedTimeBlocks: completedTimeBlocks,
      skippedTimeBlocks: skippedTimeBlocks,
      totalPlannedTimeBlocks: totalPlannedTimeBlocks,
      executionRate: executionRate,
      totalPlannedTime: Duration(minutes: totalPlannedTimeMinutes),
      totalActualTime: Duration(minutes: totalActualTimeMinutes),
      focusTime: Duration(minutes: focusTimeMinutes),
      totalTimeDifference: Duration(minutes: averageTimeDifferenceMinutes),
      timeAccuracyPercent: timeAccuracyPercent,
    );
  }

  /// Domain Entity에서 생성
  factory ProductivityStatsModel.fromEntity(ProductivityStats entity) {
    return ProductivityStatsModel(
      date: entity.date,
      score: entity.score,
      completedTasks: entity.completedTasks,
      totalPlannedTasks: entity.totalPlannedTasks,
      completedTimeBlocks: entity.completedTimeBlocks,
      skippedTimeBlocks: entity.skippedTimeBlocks,
      totalPlannedTimeBlocks: entity.totalPlannedTimeBlocks,
      executionRate: entity.executionRate,
      totalPlannedTimeMinutes: entity.totalPlannedTime.inMinutes,
      totalActualTimeMinutes: entity.totalActualTime.inMinutes,
      focusTimeMinutes: entity.focusTime.inMinutes,
      averageTimeDifferenceMinutes: entity.totalTimeDifference.inMinutes,
      timeAccuracyPercent: entity.timeAccuracyPercent,
    );
  }
}
