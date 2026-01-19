import 'package:equatable/equatable.dart';

/// Failure 베이스 클래스
///
/// Either 패턴에서 실패 케이스를 나타내는 클래스들
/// Repository에서 예외를 Failure로 변환하여 반환
abstract class Failure extends Equatable {
  final String? message;

  const Failure({this.message});

  @override
  List<Object?> get props => [message];
}

/// 서버 오류
class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure({super.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

/// 캐시 오류
class CacheFailure extends Failure {
  const CacheFailure({super.message});
}

/// 네트워크 연결 오류
class NetworkFailure extends Failure {
  const NetworkFailure({super.message});
}

/// 인증 오류
class AuthFailure extends Failure {
  const AuthFailure({super.message});
}

/// 캘린더 동기화 오류
class CalendarSyncFailure extends Failure {
  final String? provider;

  const CalendarSyncFailure({super.message, this.provider});

  @override
  List<Object?> get props => [message, provider];
}

/// 유효성 검사 오류
class ValidationFailure extends Failure {
  final String field;

  const ValidationFailure({required this.field, super.message});

  @override
  List<Object?> get props => [field, message];
}

/// 알 수 없는 오류
class UnknownFailure extends Failure {
  const UnknownFailure({super.message});
}

/// 충돌 오류 (타임블록 겹침 등)
class ConflictFailure extends Failure {
  const ConflictFailure({super.message});
}
