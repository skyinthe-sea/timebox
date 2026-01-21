// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_priority_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyPriorityModelImpl _$$DailyPriorityModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DailyPriorityModelImpl(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      rank1TaskId: json['rank1TaskId'] as String?,
      rank2TaskId: json['rank2TaskId'] as String?,
      rank3TaskId: json['rank3TaskId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$DailyPriorityModelImplToJson(
        _$DailyPriorityModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'rank1TaskId': instance.rank1TaskId,
      'rank2TaskId': instance.rank2TaskId,
      'rank3TaskId': instance.rank3TaskId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
