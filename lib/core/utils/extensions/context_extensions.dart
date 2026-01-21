import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

/// BuildContext 확장
///
/// 자주 사용하는 컨텍스트 접근자를 간편하게 사용
extension ContextExtensions on BuildContext {
  /// 테마 데이터
  ThemeData get theme => Theme.of(this);

  /// 컬러 스킴
  ColorScheme get colorScheme => theme.colorScheme;

  /// 텍스트 테마
  TextTheme get textTheme => theme.textTheme;

  /// 미디어 쿼리
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// 화면 크기
  Size get screenSize => mediaQuery.size;

  /// 화면 너비
  double get screenWidth => screenSize.width;

  /// 화면 높이
  double get screenHeight => screenSize.height;

  /// 상태바 높이
  double get statusBarHeight => mediaQuery.padding.top;

  /// 하단 안전 영역
  double get bottomPadding => mediaQuery.padding.bottom;

  /// 다크 모드 여부
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// 키보드 높이
  double get keyboardHeight => mediaQuery.viewInsets.bottom;

  /// 키보드가 열려있는지 확인
  bool get isKeyboardOpen => keyboardHeight > 0;

  /// 로컬라이제이션
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
