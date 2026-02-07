// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_time_comparison_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TagTimeComparisonModelImpl _$$TagTimeComparisonModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TagTimeComparisonModelImpl(
      tagName: json['tagName'] as String,
      colorValue: (json['colorValue'] as num).toInt(),
      totalPlannedTimeMinutes: (json['totalPlannedTimeMinutes'] as num).toInt(),
      totalActualTimeMinutes: (json['totalActualTimeMinutes'] as num).toInt(),
      taskCount: (json['taskCount'] as num).toInt(),
    );

Map<String, dynamic> _$$TagTimeComparisonModelImplToJson(
        _$TagTimeComparisonModelImpl instance) =>
    <String, dynamic>{
      'tagName': instance.tagName,
      'colorValue': instance.colorValue,
      'totalPlannedTimeMinutes': instance.totalPlannedTimeMinutes,
      'totalActualTimeMinutes': instance.totalActualTimeMinutes,
      'taskCount': instance.taskCount,
    };
