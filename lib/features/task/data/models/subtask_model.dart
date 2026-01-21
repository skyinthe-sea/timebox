import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/subtask.dart';

part 'subtask_model.freezed.dart';
part 'subtask_model.g.dart';

/// Subtask 데이터 모델
///
/// Hive 저장 및 JSON 직렬화를 위한 모델
@freezed
class SubtaskModel with _$SubtaskModel {
  const SubtaskModel._();

  const factory SubtaskModel({
    required String id,
    required String taskId,
    required String title,
    @Default(false) bool isCompleted,
    @Default(0) int order,
  }) = _SubtaskModel;

  factory SubtaskModel.fromJson(Map<String, dynamic> json) =>
      _$SubtaskModelFromJson(json);

  /// Domain Entity로 변환
  Subtask toEntity() {
    return Subtask(
      id: id,
      taskId: taskId,
      title: title,
      isCompleted: isCompleted,
      order: order,
    );
  }

  /// Domain Entity에서 생성
  factory SubtaskModel.fromEntity(Subtask subtask) {
    return SubtaskModel(
      id: subtask.id,
      taskId: subtask.taskId,
      title: subtask.title,
      isCompleted: subtask.isCompleted,
      order: subtask.order,
    );
  }
}
