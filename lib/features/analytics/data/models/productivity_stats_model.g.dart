// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productivity_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductivityStatsModelImpl _$$ProductivityStatsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductivityStatsModelImpl(
      date: DateTime.parse(json['date'] as String),
      score: (json['score'] as num).toInt(),
      completedTasks: (json['completedTasks'] as num).toInt(),
      totalPlannedTasks: (json['totalPlannedTasks'] as num).toInt(),
      completedTimeBlocks: (json['completedTimeBlocks'] as num).toInt(),
      skippedTimeBlocks: (json['skippedTimeBlocks'] as num?)?.toInt() ?? 0,
      totalPlannedTimeBlocks: (json['totalPlannedTimeBlocks'] as num).toInt(),
      executionRate: (json['executionRate'] as num).toDouble(),
      totalPlannedTimeMinutes: (json['totalPlannedTimeMinutes'] as num).toInt(),
      totalActualTimeMinutes: (json['totalActualTimeMinutes'] as num).toInt(),
      focusTimeMinutes: (json['focusTimeMinutes'] as num).toInt(),
      averageTimeDifferenceMinutes:
          (json['averageTimeDifferenceMinutes'] as num).toInt(),
      timeAccuracyPercent:
          (json['timeAccuracyPercent'] as num?)?.toDouble() ?? -1.0,
    );

Map<String, dynamic> _$$ProductivityStatsModelImplToJson(
        _$ProductivityStatsModelImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'score': instance.score,
      'completedTasks': instance.completedTasks,
      'totalPlannedTasks': instance.totalPlannedTasks,
      'completedTimeBlocks': instance.completedTimeBlocks,
      'skippedTimeBlocks': instance.skippedTimeBlocks,
      'totalPlannedTimeBlocks': instance.totalPlannedTimeBlocks,
      'executionRate': instance.executionRate,
      'totalPlannedTimeMinutes': instance.totalPlannedTimeMinutes,
      'totalActualTimeMinutes': instance.totalActualTimeMinutes,
      'focusTimeMinutes': instance.focusTimeMinutes,
      'averageTimeDifferenceMinutes': instance.averageTimeDifferenceMinutes,
      'timeAccuracyPercent': instance.timeAccuracyPercent,
    };
