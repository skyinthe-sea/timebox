import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/task_pipeline_stats.dart';

part 'task_pipeline_stats_model.freezed.dart';
part 'task_pipeline_stats_model.g.dart';

/// TaskPipelineStats 데이터 모델
///
/// Hive 저장 및 JSON 직렬화를 위한 모델
@freezed
class TaskPipelineStatsModel with _$TaskPipelineStatsModel {
  const TaskPipelineStatsModel._();

  const factory TaskPipelineStatsModel({
    required int totalTasks,
    required int scheduledTasks,
    required int completedTasks,
    required int rolledOverTasks,
  }) = _TaskPipelineStatsModel;

  factory TaskPipelineStatsModel.fromJson(Map<String, dynamic> json) =>
      _$TaskPipelineStatsModelFromJson(json);

  /// Domain Entity로 변환
  TaskPipelineStats toEntity() {
    return TaskPipelineStats(
      totalTasks: totalTasks,
      scheduledTasks: scheduledTasks,
      completedTasks: completedTasks,
      rolledOverTasks: rolledOverTasks,
    );
  }

  /// Domain Entity에서 생성
  factory TaskPipelineStatsModel.fromEntity(TaskPipelineStats entity) {
    return TaskPipelineStatsModel(
      totalTasks: entity.totalTasks,
      scheduledTasks: entity.scheduledTasks,
      completedTasks: entity.completedTasks,
      rolledOverTasks: entity.rolledOverTasks,
    );
  }
}
