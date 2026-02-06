// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'focus_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FocusSessionModelImpl _$$FocusSessionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FocusSessionModelImpl(
      id: json['id'] as String,
      timeBlockId: json['timeBlockId'] as String,
      taskId: json['taskId'] as String?,
      status: json['status'] as String? ?? 'pending',
      plannedStartTime: DateTime.parse(json['plannedStartTime'] as String),
      plannedEndTime: DateTime.parse(json['plannedEndTime'] as String),
      actualStartTime: json['actualStartTime'] == null
          ? null
          : DateTime.parse(json['actualStartTime'] as String),
      actualEndTime: json['actualEndTime'] == null
          ? null
          : DateTime.parse(json['actualEndTime'] as String),
      pauseRecords: (json['pauseRecords'] as List<dynamic>?)
              ?.map((e) => PauseRecordModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$FocusSessionModelImplToJson(
        _$FocusSessionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timeBlockId': instance.timeBlockId,
      'taskId': instance.taskId,
      'status': instance.status,
      'plannedStartTime': instance.plannedStartTime.toIso8601String(),
      'plannedEndTime': instance.plannedEndTime.toIso8601String(),
      'actualStartTime': instance.actualStartTime?.toIso8601String(),
      'actualEndTime': instance.actualEndTime?.toIso8601String(),
      'pauseRecords': instance.pauseRecords.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$PauseRecordModelImpl _$$PauseRecordModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PauseRecordModelImpl(
      pauseTime: DateTime.parse(json['pauseTime'] as String),
      resumeTime: json['resumeTime'] == null
          ? null
          : DateTime.parse(json['resumeTime'] as String),
    );

Map<String, dynamic> _$$PauseRecordModelImplToJson(
        _$PauseRecordModelImpl instance) =>
    <String, dynamic>{
      'pauseTime': instance.pauseTime.toIso8601String(),
      'resumeTime': instance.resumeTime?.toIso8601String(),
    };
