import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/focus_session.dart';
import '../entities/session_status.dart';

/// Focus Repository 인터페이스
///
/// 포커스 세션 관련 데이터 접근을 위한 추상 인터페이스
abstract class FocusRepository {
  /// 현재 진행 중인 세션 조회
  Future<Either<Failure, FocusSession?>> getCurrentSession();

  /// 세션 ID로 조회
  Future<Either<Failure, FocusSession>> getSessionById(String id);

  /// 특정 날짜의 세션 목록 조회
  Future<Either<Failure, List<FocusSession>>> getSessionsForDay(DateTime date);

  /// 포커스 세션 시작
  Future<Either<Failure, FocusSession>> startSession({
    required String timeBlockId,
    String? taskId,
  });

  /// 포커스 세션 일시 정지
  Future<Either<Failure, FocusSession>> pauseSession(String sessionId);

  /// 포커스 세션 재개
  Future<Either<Failure, FocusSession>> resumeSession(String sessionId);

  /// 포커스 세션 완료
  Future<Either<Failure, FocusSession>> completeSession(String sessionId);

  /// 포커스 세션 건너뛰기
  Future<Either<Failure, FocusSession>> skipSession(String sessionId);

  /// 포커스 세션 취소
  Future<Either<Failure, FocusSession>> cancelSession(String sessionId);

  /// 세션 시간 연장
  Future<Either<Failure, FocusSession>> extendSession(
    String sessionId,
    Duration extension,
  );

  /// 세션 상태 업데이트
  Future<Either<Failure, FocusSession>> updateSessionStatus(
    String sessionId,
    SessionStatus status,
  );

  /// 알림 예약
  Future<Either<Failure, void>> scheduleNotification({
    required String sessionId,
    required DateTime notifyAt,
    required String message,
  });

  /// 알림 취소
  Future<Either<Failure, void>> cancelNotifications(String sessionId);

  /// 현재 세션 스트림 (실시간 업데이트)
  Stream<Either<Failure, FocusSession?>> watchCurrentSession();
}
