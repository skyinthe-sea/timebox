// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtask_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubtaskModelImpl _$$SubtaskModelImplFromJson(Map<String, dynamic> json) =>
    _$SubtaskModelImpl(
      id: json['id'] as String,
      taskId: json['taskId'] as String,
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      order: (json['order'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$SubtaskModelImplToJson(_$SubtaskModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'taskId': instance.taskId,
      'title': instance.title,
      'isCompleted': instance.isCompleted,
      'order': instance.order,
    };
