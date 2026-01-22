import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/task.dart';
import 'subtask_model.dart';
import 'tag_model.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

/// Task 데이터 모델
///
/// Hive 저장 및 JSON 직렬화를 위한 모델
@freezed
class TaskModel with _$TaskModel {
  const TaskModel._();

  const factory TaskModel({
    required String id,
    required String title,
    String? note,
    required int estimatedDurationMinutes,
    @Default([]) List<TagModel> tags,
    @Default('medium') String priority,
    @Default('todo') String status,
    @Default([]) List<SubtaskModel> subtasks,
    required DateTime createdAt,
    DateTime? completedAt,
    DateTime? targetDate, // nullable for backward compatibility
    @Default(0) int rolloverCount,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  /// Domain Entity로 변환
  Task toEntity() {
    return Task(
      id: id,
      title: title,
      note: note,
      estimatedDuration: Duration(minutes: estimatedDurationMinutes),
      tags: tags.map((t) => t.toEntity()).toList(),
      priority: _priorityFromString(priority),
      status: _statusFromString(status),
      subtasks: subtasks.map((s) => s.toEntity()).toList(),
      createdAt: createdAt,
      completedAt: completedAt,
      targetDate: targetDate ?? createdAt, // fallback to createdAt for existing tasks
      rolloverCount: rolloverCount,
    );
  }

  /// Domain Entity에서 생성
  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      note: task.note,
      estimatedDurationMinutes: task.estimatedDuration.inMinutes,
      tags: task.tags.map((t) => TagModel.fromEntity(t)).toList(),
      priority: task.priority.name,
      status: task.status.name,
      subtasks: task.subtasks.map((s) => SubtaskModel.fromEntity(s)).toList(),
      createdAt: task.createdAt,
      completedAt: task.completedAt,
      targetDate: task.targetDate,
      rolloverCount: task.rolloverCount,
    );
  }

  static TaskPriority _priorityFromString(String value) {
    return TaskPriority.values.firstWhere(
      (e) => e.name == value,
      orElse: () => TaskPriority.medium,
    );
  }

  static TaskStatus _statusFromString(String value) {
    return TaskStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => TaskStatus.todo,
    );
  }
}
