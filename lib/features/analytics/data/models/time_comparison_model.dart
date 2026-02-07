import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/time_comparison.dart';

part 'time_comparison_model.freezed.dart';
part 'time_comparison_model.g.dart';

/// TimeComparison 데이터 모델
///
/// Hive 저장 및 JSON 직렬화를 위한 모델
@freezed
class TimeComparisonModel with _$TimeComparisonModel {
  const TimeComparisonModel._();

  const factory TimeComparisonModel({
    required String id,
    required String title,
    required int plannedDurationMinutes,
    required int actualDurationMinutes,
    required DateTime date,
    String? tag,
  }) = _TimeComparisonModel;

  factory TimeComparisonModel.fromJson(Map<String, dynamic> json) =>
      _$TimeComparisonModelFromJson(json);

  /// Domain Entity로 변환
  TimeComparison toEntity() {
    return TimeComparison(
      id: id,
      title: title,
      plannedDuration: Duration(minutes: plannedDurationMinutes),
      actualDuration: Duration(minutes: actualDurationMinutes),
      date: date,
      tag: tag,
    );
  }

  /// Domain Entity에서 생성
  factory TimeComparisonModel.fromEntity(TimeComparison entity) {
    return TimeComparisonModel(
      id: entity.id,
      title: entity.title,
      plannedDurationMinutes: entity.plannedDuration.inMinutes,
      actualDurationMinutes: entity.actualDuration.inMinutes,
      date: entity.date,
      tag: entity.tag,
    );
  }
}
