import 'package:flutter/material.dart';

/// Tag 엔티티
///
/// Task에 부여할 수 있는 분류 태그
///
/// 예시: 업무, 개인, 건강, 학습 등
class Tag {
  /// 고유 식별자
  final String id;

  /// 태그 이름
  final String name;

  /// 태그 색상
  final Color color;

  /// 아이콘 (선택)
  final IconData? icon;

  const Tag({
    required this.id,
    required this.name,
    required this.color,
    this.icon,
  });

  // TODO: copyWith, props (Equatable), toJson/fromJson 구현
}

/// 기본 태그 목록
abstract class DefaultTags {
  static const Tag work = Tag(
    id: 'work',
    name: 'Work',
    color: Color(0xFF3B82F6), // Blue
    icon: Icons.work,
  );

  static const Tag personal = Tag(
    id: 'personal',
    name: 'Personal',
    color: Color(0xFF10B981), // Green
    icon: Icons.person,
  );

  static const Tag health = Tag(
    id: 'health',
    name: 'Health',
    color: Color(0xFFEF4444), // Red
    icon: Icons.favorite,
  );

  static const Tag study = Tag(
    id: 'study',
    name: 'Study',
    color: Color(0xFFF59E0B), // Amber
    icon: Icons.school,
  );

  static const List<Tag> all = [work, personal, health, study];
}
