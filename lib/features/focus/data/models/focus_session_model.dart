import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/focus_session.dart';
import '../../domain/entities/session_status.dart';

part 'focus_session_model.freezed.dart';
part 'focus_session_model.g.dart';

/// FocusSession 데이터 모델
@freezed
class FocusSessionModel with _$FocusSessionModel {
  const FocusSessionModel._();

  const factory FocusSessionModel({
    required String id,
    required String timeBlockId,
    String? taskId,
    @Default('pending') String status,
    required DateTime plannedStartTime,
    required DateTime plannedEndTime,
    DateTime? actualStartTime,
    DateTime? actualEndTime,
    @Default([]) List<PauseRecordModel> pauseRecords,
    required DateTime createdAt,
  }) = _FocusSessionModel;

  factory FocusSessionModel.fromJson(Map<String, dynamic> json) =>
      _$FocusSessionModelFromJson(json);

  FocusSession toEntity() {
    return FocusSession(
      id: id,
      timeBlockId: timeBlockId,
      taskId: taskId,
      status: SessionStatus.values.firstWhere(
        (e) => e.name == status,
        orElse: () => SessionStatus.pending,
      ),
      plannedStartTime: plannedStartTime,
      plannedEndTime: plannedEndTime,
      actualStartTime: actualStartTime,
      actualEndTime: actualEndTime,
      pauseRecords: pauseRecords.map((p) => p.toEntity()).toList(),
      createdAt: createdAt,
    );
  }

  factory FocusSessionModel.fromEntity(FocusSession session) {
    return FocusSessionModel(
      id: session.id,
      timeBlockId: session.timeBlockId,
      taskId: session.taskId,
      status: session.status.name,
      plannedStartTime: session.plannedStartTime,
      plannedEndTime: session.plannedEndTime,
      actualStartTime: session.actualStartTime,
      actualEndTime: session.actualEndTime,
      pauseRecords:
          session.pauseRecords.map((p) => PauseRecordModel.fromEntity(p)).toList(),
      createdAt: session.createdAt,
    );
  }
}

@freezed
class PauseRecordModel with _$PauseRecordModel {
  const PauseRecordModel._();

  const factory PauseRecordModel({
    required DateTime pauseTime,
    DateTime? resumeTime,
  }) = _PauseRecordModel;

  factory PauseRecordModel.fromJson(Map<String, dynamic> json) =>
      _$PauseRecordModelFromJson(json);

  PauseRecord toEntity() {
    return PauseRecord(
      pauseTime: pauseTime,
      resumeTime: resumeTime,
    );
  }

  factory PauseRecordModel.fromEntity(PauseRecord record) {
    return PauseRecordModel(
      pauseTime: record.pauseTime,
      resumeTime: record.resumeTime,
    );
  }
}
