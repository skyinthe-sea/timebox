import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/task_completion_ranking.dart';

part 'task_completion_ranking_model.freezed.dart';
part 'task_completion_ranking_model.g.dart';

/// TaskCompletionRanking 데이터 모델
///
/// Hive 저장 및 JSON 직렬화를 위한 모델
@freezed
class TaskCompletionRankingModel with _$TaskCompletionRankingModel {
  const TaskCompletionRankingModel._();

  const factory TaskCompletionRankingModel({
    required String title,
    required int totalCount,
    required int completedCount,
    required double completionRate,
  }) = _TaskCompletionRankingModel;

  factory TaskCompletionRankingModel.fromJson(Map<String, dynamic> json) =>
      _$TaskCompletionRankingModelFromJson(json);

  /// Domain Entity로 변환
  TaskCompletionRanking toEntity() {
    return TaskCompletionRanking(
      title: title,
      totalCount: totalCount,
      completedCount: completedCount,
      completionRate: completionRate,
    );
  }

  /// Domain Entity에서 생성
  factory TaskCompletionRankingModel.fromEntity(TaskCompletionRanking entity) {
    return TaskCompletionRankingModel(
      title: entity.title,
      totalCount: entity.totalCount,
      completedCount: entity.completedCount,
      completionRate: entity.completionRate,
    );
  }
}
