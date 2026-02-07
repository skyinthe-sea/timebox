import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/time_comparison.dart';

part 'tag_time_comparison_model.freezed.dart';
part 'tag_time_comparison_model.g.dart';

/// TagTimeComparison 데이터 모델
///
/// Hive 저장 및 JSON 직렬화를 위한 모델
@freezed
class TagTimeComparisonModel with _$TagTimeComparisonModel {
  const TagTimeComparisonModel._();

  const factory TagTimeComparisonModel({
    required String tagName,
    required int colorValue,
    required int totalPlannedTimeMinutes,
    required int totalActualTimeMinutes,
    required int taskCount,
  }) = _TagTimeComparisonModel;

  factory TagTimeComparisonModel.fromJson(Map<String, dynamic> json) =>
      _$TagTimeComparisonModelFromJson(json);

  /// Domain Entity로 변환
  TagTimeComparison toEntity() {
    return TagTimeComparison(
      tagName: tagName,
      colorValue: colorValue,
      totalPlannedTime: Duration(minutes: totalPlannedTimeMinutes),
      totalActualTime: Duration(minutes: totalActualTimeMinutes),
      taskCount: taskCount,
    );
  }

  /// Domain Entity에서 생성
  factory TagTimeComparisonModel.fromEntity(TagTimeComparison entity) {
    return TagTimeComparisonModel(
      tagName: entity.tagName,
      colorValue: entity.colorValue,
      totalPlannedTimeMinutes: entity.totalPlannedTime.inMinutes,
      totalActualTimeMinutes: entity.totalActualTime.inMinutes,
      taskCount: entity.taskCount,
    );
  }
}
