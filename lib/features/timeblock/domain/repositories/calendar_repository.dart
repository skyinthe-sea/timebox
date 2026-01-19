import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/calendar_event.dart';

/// Calendar Repository 인터페이스
///
/// 외부 캘린더 동기화를 위한 추상 인터페이스
abstract class CalendarRepository {
  /// Google Calendar 연결
  Future<Either<Failure, void>> connectGoogleCalendar();

  /// Outlook Calendar 연결
  Future<Either<Failure, void>> connectOutlookCalendar();

  /// Apple Calendar 연결
  Future<Either<Failure, void>> connectAppleCalendar();

  /// 캘린더 연결 해제
  Future<Either<Failure, void>> disconnectCalendar(String provider);

  /// 연결된 캘린더 목록 조회
  Future<Either<Failure, List<String>>> getConnectedCalendars();

  /// 특정 날짜의 외부 일정 조회
  Future<Either<Failure, List<CalendarEvent>>> getEventsForDay(
    DateTime date, {
    String? provider,
  });

  /// 날짜 범위의 외부 일정 조회
  Future<Either<Failure, List<CalendarEvent>>> getEventsForRange(
    DateTime start,
    DateTime end, {
    String? provider,
  });

  /// 외부 캘린더 동기화
  Future<Either<Failure, void>> syncCalendar(String provider);

  /// 모든 연결된 캘린더 동기화
  Future<Either<Failure, void>> syncAllCalendars();

  /// 마지막 동기화 시간 조회
  Future<Either<Failure, DateTime?>> getLastSyncTime(String provider);
}
