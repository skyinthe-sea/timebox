// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_block_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimeBlockModelImpl _$$TimeBlockModelImplFromJson(Map<String, dynamic> json) =>
    _$TimeBlockModelImpl(
      id: json['id'] as String,
      taskId: json['taskId'] as String?,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      actualStart: json['actualStart'] == null
          ? null
          : DateTime.parse(json['actualStart'] as String),
      actualEnd: json['actualEnd'] == null
          ? null
          : DateTime.parse(json['actualEnd'] as String),
      isExternal: json['isExternal'] as bool? ?? false,
      externalEventId: json['externalEventId'] as String?,
      externalProvider: json['externalProvider'] as String?,
      status: json['status'] as String? ?? 'pending',
      colorValue: (json['colorValue'] as num?)?.toInt(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$$TimeBlockModelImplToJson(
        _$TimeBlockModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'taskId': instance.taskId,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'actualStart': instance.actualStart?.toIso8601String(),
      'actualEnd': instance.actualEnd?.toIso8601String(),
      'isExternal': instance.isExternal,
      'externalEventId': instance.externalEventId,
      'externalProvider': instance.externalProvider,
      'status': instance.status,
      'colorValue': instance.colorValue,
      'title': instance.title,
    };
