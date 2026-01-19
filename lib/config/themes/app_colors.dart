import 'package:flutter/material.dart';

/// 앱 컬러 팔레트
///
/// 2026 트렌디 컬러 시스템
/// - Primary: Indigo 계열 (집중, 생산성)
/// - Secondary: Pink 계열 (액센트, 강조)
abstract class AppColors {
  //===========================================================================
  // Light Mode
  //===========================================================================
  static const Color primaryLight = Color(0xFF6366F1);
  static const Color secondaryLight = Color(0xFFF472B6);
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color onSecondaryLight = Color(0xFFFFFFFF);
  static const Color onBackgroundLight = Color(0xFF171717);
  static const Color borderLight = Color(0xFFE5E5E5);

  // Semantic Colors - Light
  static const Color successLight = Color(0xFF10B981);
  static const Color warningLight = Color(0xFFF59E0B);
  static const Color errorLight = Color(0xFFEF4444);

  //===========================================================================
  // Dark Mode
  //===========================================================================
  static const Color primaryDark = Color(0xFF818CF8);
  static const Color secondaryDark = Color(0xFFF9A8D4);
  static const Color backgroundDark = Color(0xFF0F0F0F);
  static const Color surfaceDark = Color(0xFF1A1A1A);
  static const Color onPrimaryDark = Color(0xFF000000);
  static const Color onSecondaryDark = Color(0xFF000000);
  static const Color onBackgroundDark = Color(0xFFFAFAFA);
  static const Color borderDark = Color(0xFF2A2A2A);

  // Semantic Colors - Dark
  static const Color successDark = Color(0xFF34D399);
  static const Color warningDark = Color(0xFFFBBF24);
  static const Color errorDark = Color(0xFFF87171);

  //===========================================================================
  // Priority Colors (공통)
  //===========================================================================
  static const Color priorityHigh = Color(0xFFEF4444);
  static const Color priorityMedium = Color(0xFFF59E0B);
  static const Color priorityLow = Color(0xFF10B981);

  //===========================================================================
  // Status Colors (공통)
  //===========================================================================
  static const Color statusInProgress = Color(0xFF3B82F6);
  static const Color statusCompleted = Color(0xFF10B981);
  static const Color statusDelayed = Color(0xFFF59E0B);
  static const Color statusSkipped = Color(0xFF6B7280);
}
