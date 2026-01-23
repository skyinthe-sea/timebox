import 'dart:io';

import 'package:flutter/foundation.dart';

/// AdMob 광고 설정
///
/// 개발 모드에서는 테스트 광고 ID 사용,
/// 프로덕션에서는 실제 광고 ID 사용
abstract class AdConfig {
  // 테스트 광고 ID (Google 제공 공식 테스트 ID)
  static const String _testBannerAdUnitIdAndroid =
      'ca-app-pub-3940256099942544/6300978111';
  static const String _testBannerAdUnitIdIOS =
      'ca-app-pub-3940256099942544/2934735716';

  // 실제 광고 ID (FlowBox)
  static const String _prodBannerAdUnitIdAndroid =
      'ca-app-pub-6902355178006305/5877553065';
  static const String _prodBannerAdUnitIdIOS =
      'ca-app-pub-6902355178006305/1583402062';

  /// 현재 환경이 테스트 모드인지 확인
  /// - kDebugMode: 디버그 빌드
  /// - kProfileMode: 프로파일 빌드
  /// - kReleaseMode: 릴리스 빌드 (프로덕션)
  static bool get isTestMode => kDebugMode || kProfileMode;

  /// 배너 광고 단위 ID
  /// 테스트 모드면 테스트 ID, 아니면 실제 ID 반환
  static String get bannerAdUnitId {
    if (isTestMode) {
      return Platform.isAndroid
          ? _testBannerAdUnitIdAndroid
          : _testBannerAdUnitIdIOS;
    }
    return Platform.isAndroid
        ? _prodBannerAdUnitIdAndroid
        : _prodBannerAdUnitIdIOS;
  }

  /// 광고 요청 타임아웃 (초)
  static const int adLoadTimeout = 30;

  /// 광고 새로고침 간격 (초) - 최소 30초 권장
  static const int adRefreshInterval = 60;
}
