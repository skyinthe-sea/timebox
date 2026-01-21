import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/daily_priority.dart';

part 'daily_priority_model.freezed.dart';
part 'daily_priority_model.g.dart';

/// DailyPriority 데이터 모델
///
/// Hive 저장 및 JSON 직렬화를 위한 모델
@freezed
class DailyPriorityModel with _$DailyPriorityModel {
  const DailyPriorityModel._();

  const factory DailyPriorityModel({
    required String id,
    required DateTime date,
    String? rank1TaskId,
    String? rank2TaskId,
    String? rank3TaskId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DailyPriorityModel;

  factory DailyPriorityModel.fromJson(Map<String, dynamic> json) =>
      _$DailyPriorityModelFromJson(json);

  /// Domain Entity로 변환
  DailyPriority toEntity() {
    return DailyPriority(
      id: id,
      date: date,
      rank1TaskId: rank1TaskId,
      rank2TaskId: rank2TaskId,
      rank3TaskId: rank3TaskId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Domain Entity에서 생성
  factory DailyPriorityModel.fromEntity(DailyPriority entity) {
    return DailyPriorityModel(
      id: entity.id,
      date: entity.date,
      rank1TaskId: entity.rank1TaskId,
      rank2TaskId: entity.rank2TaskId,
      rank3TaskId: entity.rank3TaskId,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// 날짜 키 생성 (yyyy-MM-dd 형식)
  String get dateKey {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
