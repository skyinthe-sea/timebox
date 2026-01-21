import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/tag.dart';

part 'tag_model.freezed.dart';
part 'tag_model.g.dart';

/// Tag 데이터 모델
///
/// Hive 저장 및 JSON 직렬화를 위한 모델
@freezed
class TagModel with _$TagModel {
  const TagModel._();

  const factory TagModel({
    required String id,
    required String name,
    required int colorValue,
    String? iconCodePoint,
  }) = _TagModel;

  factory TagModel.fromJson(Map<String, dynamic> json) =>
      _$TagModelFromJson(json);

  /// Domain Entity로 변환
  Tag toEntity() {
    return Tag(
      id: id,
      name: name,
      color: Color(colorValue),
      icon: iconCodePoint != null
          ? IconData(int.parse(iconCodePoint!), fontFamily: 'MaterialIcons')
          : null,
    );
  }

  /// Domain Entity에서 생성
  factory TagModel.fromEntity(Tag tag) {
    return TagModel(
      id: tag.id,
      name: tag.name,
      colorValue: tag.color.toARGB32(),
      iconCodePoint: tag.icon?.codePoint.toString(),
    );
  }
}
