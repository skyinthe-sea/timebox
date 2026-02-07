// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_pipeline_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskPipelineStatsModelImpl _$$TaskPipelineStatsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TaskPipelineStatsModelImpl(
      totalTasks: (json['totalTasks'] as num).toInt(),
      scheduledTasks: (json['scheduledTasks'] as num).toInt(),
      completedTasks: (json['completedTasks'] as num).toInt(),
      rolledOverTasks: (json['rolledOverTasks'] as num).toInt(),
    );

Map<String, dynamic> _$$TaskPipelineStatsModelImplToJson(
        _$TaskPipelineStatsModelImpl instance) =>
    <String, dynamic>{
      'totalTasks': instance.totalTasks,
      'scheduledTasks': instance.scheduledTasks,
      'completedTasks': instance.completedTasks,
      'rolledOverTasks': instance.rolledOverTasks,
    };
