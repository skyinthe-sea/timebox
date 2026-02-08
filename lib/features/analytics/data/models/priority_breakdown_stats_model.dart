import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/priority_breakdown_stats.dart';

part 'priority_breakdown_stats_model.freezed.dart';
part 'priority_breakdown_stats_model.g.dart';

/// PriorityBreakdownStats 데이터 모델
///
/// Hive 저장 및 JSON 직렬화를 위한 모델
@freezed
class PriorityBreakdownStatsModel with _$PriorityBreakdownStatsModel {
  const PriorityBreakdownStatsModel._();

  const factory PriorityBreakdownStatsModel({
    required int highTotal,
    required int highCompleted,
    required int mediumTotal,
    required int mediumCompleted,
    required int lowTotal,
    required int lowCompleted,
  }) = _PriorityBreakdownStatsModel;

  factory PriorityBreakdownStatsModel.fromJson(Map<String, dynamic> json) =>
      _$PriorityBreakdownStatsModelFromJson(json);

  /// Domain Entity로 변환
  PriorityBreakdownStats toEntity() {
    return PriorityBreakdownStats(
      high: PriorityStat(total: highTotal, completed: highCompleted),
      medium: PriorityStat(total: mediumTotal, completed: mediumCompleted),
      low: PriorityStat(total: lowTotal, completed: lowCompleted),
    );
  }

  /// Domain Entity에서 생성
  factory PriorityBreakdownStatsModel.fromEntity(PriorityBreakdownStats entity) {
    return PriorityBreakdownStatsModel(
      highTotal: entity.high.total,
      highCompleted: entity.high.completed,
      mediumTotal: entity.medium.total,
      mediumCompleted: entity.medium.completed,
      lowTotal: entity.low.total,
      lowCompleted: entity.low.completed,
    );
  }
}
