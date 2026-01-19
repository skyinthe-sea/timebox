// 커스텀 예외 클래스
//
// 앱에서 발생하는 다양한 예외 상황을 처리하기 위한 클래스들

/// 서버 관련 예외
class ServerException implements Exception {
  final String? message;
  final int? statusCode;

  const ServerException({this.message, this.statusCode});

  @override
  String toString() => 'ServerException: $message (status: $statusCode)';
}

/// 캐시 관련 예외
class CacheException implements Exception {
  final String? message;

  const CacheException({this.message});

  @override
  String toString() => 'CacheException: $message';
}

/// 네트워크 연결 예외
class NetworkException implements Exception {
  final String? message;

  const NetworkException({this.message});

  @override
  String toString() => 'NetworkException: $message';
}

/// 인증 관련 예외
class AuthException implements Exception {
  final String? message;

  const AuthException({this.message});

  @override
  String toString() => 'AuthException: $message';
}

/// 캘린더 동기화 예외
class CalendarSyncException implements Exception {
  final String? message;
  final String? provider; // google, outlook, apple

  const CalendarSyncException({this.message, this.provider});

  @override
  String toString() => 'CalendarSyncException: $message (provider: $provider)';
}

/// 유효성 검사 예외
class ValidationException implements Exception {
  final String field;
  final String? message;

  const ValidationException({required this.field, this.message});

  @override
  String toString() => 'ValidationException: $field - $message';
}
