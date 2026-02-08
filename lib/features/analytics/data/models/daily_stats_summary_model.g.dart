// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_stats_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyStatsSummaryModelImpl _$$DailyStatsSummaryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DailyStatsSummaryModelImpl(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      totalPlannedTasks: (json['totalPlannedTasks'] as num).toInt(),
      completedTasks: (json['completedTasks'] as num).toInt(),
      rolledOverTasks: (json['rolledOverTasks'] as num?)?.toInt() ?? 0,
      totalTimeBlocks: (json['totalTimeBlocks'] as num).toInt(),
      completedTimeBlocks: (json['completedTimeBlocks'] as num).toInt(),
      totalPlannedDurationMinutes:
          (json['totalPlannedDurationMinutes'] as num).toInt(),
      totalActualDurationMinutes:
          (json['totalActualDurationMinutes'] as num).toInt(),
      focusSessionCount: (json['focusSessionCount'] as num?)?.toInt() ?? 0,
      totalFocusDurationMinutes:
          (json['totalFocusDurationMinutes'] as num?)?.toInt() ?? 0,
      totalPauseDurationMinutes:
          (json['totalPauseDurationMinutes'] as num?)?.toInt() ?? 0,
      top3SetCount: (json['top3SetCount'] as num?)?.toInt() ?? 0,
      top3CompletedCount: (json['top3CompletedCount'] as num?)?.toInt() ?? 0,
      timeAccuracyPercent:
          (json['timeAccuracyPercent'] as num?)?.toDouble() ?? -1.0,
      productivityScore: (json['productivityScore'] as num).toInt(),
      calculatedAt: DateTime.parse(json['calculatedAt'] as String),
    );

Map<String, dynamic> _$$DailyStatsSummaryModelImplToJson(
        _$DailyStatsSummaryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'totalPlannedTasks': instance.totalPlannedTasks,
      'completedTasks': instance.completedTasks,
      'rolledOverTasks': instance.rolledOverTasks,
      'totalTimeBlocks': instance.totalTimeBlocks,
      'completedTimeBlocks': instance.completedTimeBlocks,
      'totalPlannedDurationMinutes': instance.totalPlannedDurationMinutes,
      'totalActualDurationMinutes': instance.totalActualDurationMinutes,
      'focusSessionCount': instance.focusSessionCount,
      'totalFocusDurationMinutes': instance.totalFocusDurationMinutes,
      'totalPauseDurationMinutes': instance.totalPauseDurationMinutes,
      'top3SetCount': instance.top3SetCount,
      'top3CompletedCount': instance.top3CompletedCount,
      'timeAccuracyPercent': instance.timeAccuracyPercent,
      'productivityScore': instance.productivityScore,
      'calculatedAt': instance.calculatedAt.toIso8601String(),
    };
