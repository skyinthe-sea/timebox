import 'package:flutter/material.dart';

/// 앱 애니메이션 상수
///
/// 일관된 애니메이션 경험을 위한 Duration 및 Curve 정의
abstract class AppAnimations {
  //===========================================================================
  // Duration
  //===========================================================================

  /// 매우 빠른 애니메이션 (100ms)
  /// - 터치 피드백, 체크박스 토글
  static const Duration fastest = Duration(milliseconds: 100);

  /// 빠른 애니메이션 (150ms)
  /// - 버튼 호버, 아이콘 전환
  static const Duration fast = Duration(milliseconds: 150);

  /// 기본 애니메이션 (200ms)
  /// - 카드 확대/축소, 색상 전환
  static const Duration normal = Duration(milliseconds: 200);

  /// 중간 애니메이션 (300ms)
  /// - 페이지 전환, 모달 열기
  static const Duration medium = Duration(milliseconds: 300);

  /// 느린 애니메이션 (400ms)
  /// - 리스트 아이템 추가/삭제
  static const Duration slow = Duration(milliseconds: 400);

  /// 매우 느린 애니메이션 (500ms)
  /// - 복잡한 레이아웃 변화
  static const Duration slowest = Duration(milliseconds: 500);

  //===========================================================================
  // Curves
  //===========================================================================

  /// 기본 이징 (자연스러운 시작과 끝)
  static const Curve defaultCurve = Curves.easeInOut;

  /// 빠른 시작 (긴장감 있는 인터랙션)
  static const Curve quickStart = Curves.easeOut;

  /// 부드러운 반동
  static const Curve bounce = Curves.elasticOut;

  /// 빠른 종료 (드래그 해제)
  static const Curve decelerate = Curves.decelerate;

  /// 오버슈트 (약간의 반동)
  static const Curve overshoot = Curves.easeOutBack;

  //===========================================================================
  // Scale Values
  //===========================================================================

  /// 터치 축소 스케일
  static const double tapScale = 0.95;

  /// 드래그 확대 스케일
  static const double dragScale = 1.05;

  /// 드래그 원본 투명도
  static const double dragChildOpacity = 0.3;

  /// 드롭 타겟 확대 스케일
  static const double dropTargetScale = 1.08;

  //===========================================================================
  // Helper Methods
  //===========================================================================

  /// 진입 애니메이션 생성
  static Animation<Offset> createSlideInAnimation(
    AnimationController controller, {
    Offset begin = const Offset(0, 0.1),
    Offset end = Offset.zero,
    Curve curve = Curves.easeOut,
  }) {
    return Tween<Offset>(begin: begin, end: end).animate(
      CurvedAnimation(parent: controller, curve: curve),
    );
  }

  /// 페이드 인 애니메이션 생성
  static Animation<double> createFadeInAnimation(
    AnimationController controller, {
    double begin = 0.0,
    double end = 1.0,
    Curve curve = Curves.easeIn,
  }) {
    return Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(parent: controller, curve: curve),
    );
  }

  /// 스케일 애니메이션 생성
  static Animation<double> createScaleAnimation(
    AnimationController controller, {
    double begin = 0.8,
    double end = 1.0,
    Curve curve = Curves.easeOut,
  }) {
    return Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(parent: controller, curve: curve),
    );
  }
}
