import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

/// 앱 테마 설정
///
/// 2026 트렌디 컬러 기반 라이트/다크 테마 정의
/// - Primary: Indigo (#6366F1 / #818CF8)
/// - Secondary: Pink (#F472B6 / #F9A8D4)
class AppTheme {
  AppTheme._();

  /// 라이트 테마
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryLight,
        secondary: AppColors.secondaryLight,
        surface: AppColors.surfaceLight,
        error: AppColors.errorLight,
        onPrimary: AppColors.onPrimaryLight,
        onSecondary: AppColors.onSecondaryLight,
        onSurface: AppColors.onBackgroundLight,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.backgroundLight,
      dividerColor: AppColors.borderLight,
      textTheme: AppTextStyles.textTheme,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
      ),
      // TODO: 추가 테마 설정 (버튼, 카드, 입력 필드 등)
    );
  }

  /// 다크 테마
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primaryDark,
        secondary: AppColors.secondaryDark,
        surface: AppColors.surfaceDark,
        error: AppColors.errorDark,
        onPrimary: AppColors.onPrimaryDark,
        onSecondary: AppColors.onSecondaryDark,
        onSurface: AppColors.onBackgroundDark,
        onError: Colors.black,
      ),
      scaffoldBackgroundColor: AppColors.backgroundDark,
      dividerColor: AppColors.borderDark,
      textTheme: AppTextStyles.textTheme,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
      ),
      // TODO: 추가 테마 설정 (버튼, 카드, 입력 필드 등)
    );
  }
}
