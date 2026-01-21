import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/time_block.dart';

part 'time_block_model.freezed.dart';
part 'time_block_model.g.dart';

/// TimeBlock 데이터 모델
///
/// Hive 저장 및 JSON 직렬화를 위한 모델
@freezed
class TimeBlockModel with _$TimeBlockModel {
  const TimeBlockModel._();

  const factory TimeBlockModel({
    required String id,
    String? taskId,
    required DateTime startTime,
    required DateTime endTime,
    DateTime? actualStart,
    DateTime? actualEnd,
    @Default(false) bool isExternal,
    String? externalEventId,
    String? externalProvider,
    @Default('pending') String status,
    int? colorValue,
    String? title,
  }) = _TimeBlockModel;

  factory TimeBlockModel.fromJson(Map<String, dynamic> json) =>
      _$TimeBlockModelFromJson(json);

  /// Domain Entity로 변환
  TimeBlock toEntity() {
    return TimeBlock(
      id: id,
      taskId: taskId,
      startTime: startTime,
      endTime: endTime,
      actualStart: actualStart,
      actualEnd: actualEnd,
      isExternal: isExternal,
      externalEventId: externalEventId,
      externalProvider: externalProvider,
      status: _statusFromString(status),
      colorValue: colorValue,
      title: title,
    );
  }

  /// Domain Entity에서 생성
  factory TimeBlockModel.fromEntity(TimeBlock timeBlock) {
    return TimeBlockModel(
      id: timeBlock.id,
      taskId: timeBlock.taskId,
      startTime: timeBlock.startTime,
      endTime: timeBlock.endTime,
      actualStart: timeBlock.actualStart,
      actualEnd: timeBlock.actualEnd,
      isExternal: timeBlock.isExternal,
      externalEventId: timeBlock.externalEventId,
      externalProvider: timeBlock.externalProvider,
      status: timeBlock.status.name,
      colorValue: timeBlock.colorValue,
      title: timeBlock.title,
    );
  }

  static TimeBlockStatus _statusFromString(String value) {
    return TimeBlockStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => TimeBlockStatus.pending,
    );
  }
}
