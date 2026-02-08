// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'priority_breakdown_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PriorityBreakdownStatsModelImpl _$$PriorityBreakdownStatsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PriorityBreakdownStatsModelImpl(
      highTotal: (json['highTotal'] as num).toInt(),
      highCompleted: (json['highCompleted'] as num).toInt(),
      mediumTotal: (json['mediumTotal'] as num).toInt(),
      mediumCompleted: (json['mediumCompleted'] as num).toInt(),
      lowTotal: (json['lowTotal'] as num).toInt(),
      lowCompleted: (json['lowCompleted'] as num).toInt(),
    );

Map<String, dynamic> _$$PriorityBreakdownStatsModelImplToJson(
        _$PriorityBreakdownStatsModelImpl instance) =>
    <String, dynamic>{
      'highTotal': instance.highTotal,
      'highCompleted': instance.highCompleted,
      'mediumTotal': instance.mediumTotal,
      'mediumCompleted': instance.mediumCompleted,
      'lowTotal': instance.lowTotal,
      'lowCompleted': instance.lowCompleted,
    };
