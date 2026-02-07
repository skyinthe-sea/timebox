// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_comparison_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimeComparisonModelImpl _$$TimeComparisonModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TimeComparisonModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      plannedDurationMinutes: (json['plannedDurationMinutes'] as num).toInt(),
      actualDurationMinutes: (json['actualDurationMinutes'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
      tag: json['tag'] as String?,
    );

Map<String, dynamic> _$$TimeComparisonModelImplToJson(
        _$TimeComparisonModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'plannedDurationMinutes': instance.plannedDurationMinutes,
      'actualDurationMinutes': instance.actualDurationMinutes,
      'date': instance.date.toIso8601String(),
      'tag': instance.tag,
    };
