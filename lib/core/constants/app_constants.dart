/// 앱 전역 상수
///
/// 앱 전반에서 사용되는 상수값 정의
abstract class AppConstants {
  // 앱 정보
  static const String appName = 'Timebox Planner';
  static const String appVersion = '1.0.0';

  // 타임박스 기본 설정
  static const int defaultTimeBlockMinutes = 30;
  static const int minTimeBlockMinutes = 5;
  static const int maxTimeBlockMinutes = 480; // 8시간

  // 알림 설정
  static const int notificationBeforeStartMinutes = 5;
  static const int notificationBeforeEndMinutes = 5;

  // 캘린더 설정
  static const int dayStartHour = 6; // 오전 6시
  static const int dayEndHour = 24; // 자정
  static const int timeSlotHeightDp = 60; // 1시간 높이

  // 애니메이션
  static const int animationDurationMs = 300;
  static const int shortAnimationDurationMs = 150;

  // 페이지네이션
  static const int defaultPageSize = 20;

  // 디바운스
  static const int searchDebounceMs = 300;
}
