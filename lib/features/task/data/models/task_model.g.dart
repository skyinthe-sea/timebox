// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskModelImpl _$$TaskModelImplFromJson(Map<String, dynamic> json) =>
    _$TaskModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      note: json['note'] as String?,
      estimatedDurationMinutes:
          (json['estimatedDurationMinutes'] as num).toInt(),
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => TagModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      priority: json['priority'] as String? ?? 'medium',
      status: json['status'] as String? ?? 'todo',
      subtasks: (json['subtasks'] as List<dynamic>?)
              ?.map((e) => SubtaskModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      targetDate: json['targetDate'] == null
          ? null
          : DateTime.parse(json['targetDate'] as String),
      rolloverCount: (json['rolloverCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$TaskModelImplToJson(_$TaskModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'note': instance.note,
      'estimatedDurationMinutes': instance.estimatedDurationMinutes,
      'tags': instance.tags,
      'priority': instance.priority,
      'status': instance.status,
      'subtasks': instance.subtasks,
      'createdAt': instance.createdAt.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'targetDate': instance.targetDate?.toIso8601String(),
      'rolloverCount': instance.rolloverCount,
    };
