/// 라우트 이름 상수
///
/// 타입 안전한 라우팅을 위한 상수 정의
abstract class RouteNames {
  // 메인 라우트
  static const String home = '/';
  static const String calendar = '/calendar';
  static const String focus = '/focus';
  static const String statistics = '/statistics';
  static const String settings = '/settings';

  // Settings 하위
  static const String profile = '/settings/profile';
  static const String notifications = '/settings/notifications';
  static const String calendarSettings = '/settings/calendar';
  static const String appearance = '/settings/appearance';
}
