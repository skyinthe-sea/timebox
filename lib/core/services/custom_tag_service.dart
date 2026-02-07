import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/task/domain/entities/tag.dart';

/// 커스텀 태그 관리 서비스
///
/// SharedPreferences를 사용하여 사용자가 만든 커스텀 태그를 저장/불러오기
class CustomTagService {
  static const String _customTagsKey = 'custom_tags';

  final SharedPreferences _prefs;

  CustomTagService(this._prefs);

  /// 기본 태그 + 커스텀 태그 모두 반환
  List<Tag> getAllTags() {
    final customTags = getCustomTags();
    return [...DefaultTags.all, ...customTags];
  }

  /// 커스텀 태그만 반환
  List<Tag> getCustomTags() {
    final jsonString = _prefs.getString(_customTagsKey);
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }

    try {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((item) => _tagFromJson(item)).toList();
    } catch (e) {
      return [];
    }
  }

  /// 커스텀 태그 추가
  Future<void> addCustomTag(Tag tag) async {
    final customTags = getCustomTags();
    // 중복 체크
    if (customTags.any((t) => t.id == tag.id || t.name == tag.name)) {
      return;
    }
    customTags.add(tag);
    await _saveCustomTags(customTags);
  }

  /// 커스텀 태그 삭제
  Future<void> removeCustomTag(String tagId) async {
    final customTags = getCustomTags();
    customTags.removeWhere((t) => t.id == tagId);
    await _saveCustomTags(customTags);
  }

  Future<void> _saveCustomTags(List<Tag> tags) async {
    final jsonList = tags.map((t) => _tagToJson(t)).toList();
    await _prefs.setString(_customTagsKey, json.encode(jsonList));
  }

  Map<String, dynamic> _tagToJson(Tag tag) {
    return {
      'id': tag.id,
      'name': tag.name,
      'color': tag.color.toARGB32(),
    };
  }

  Tag _tagFromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'] as String,
      name: json['name'] as String,
      color: Color(json['color'] as int),
    );
  }
}

/// 커스텀 태그 색상 팔레트
abstract class TagColorPalette {
  static const List<Color> colors = [
    Color(0xFF3B82F6), // Blue
    Color(0xFF10B981), // Green
    Color(0xFFEF4444), // Red
    Color(0xFFF59E0B), // Amber
    Color(0xFF8B5CF6), // Violet
    Color(0xFFEC4899), // Pink
    Color(0xFF06B6D4), // Cyan
    Color(0xFFF97316), // Orange
    Color(0xFF84CC16), // Lime
    Color(0xFF6366F1), // Indigo
  ];
}
