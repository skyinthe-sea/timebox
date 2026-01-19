import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_settings.dart';

/// Settings Repository 인터페이스
///
/// 사용자 설정 데이터 접근을 위한 추상 인터페이스
abstract class SettingsRepository {
  /// 현재 설정 조회
  Future<Either<Failure, UserSettings>> getSettings();

  /// 설정 업데이트
  Future<Either<Failure, UserSettings>> updateSettings(UserSettings settings);

  /// 테마 모드 변경
  Future<Either<Failure, void>> setThemeMode(String mode);

  /// 언어 변경
  Future<Either<Failure, void>> setLanguage(String languageCode);

  /// 알림 설정 변경
  Future<Either<Failure, void>> setNotificationsEnabled(bool enabled);

  /// 알림 시간 설정
  Future<Either<Failure, void>> setNotificationTiming({
    int? beforeStartMinutes,
    int? beforeEndMinutes,
  });

  /// 하루 시간 범위 설정
  Future<Either<Failure, void>> setDayTimeRange({
    int? startHour,
    int? endHour,
  });

  /// 기본 타임박스 길이 설정
  Future<Either<Failure, void>> setDefaultTimeBlockMinutes(int minutes);

  /// 캘린더 연결 추가
  Future<Either<Failure, void>> addConnectedCalendar(String provider);

  /// 캘린더 연결 제거
  Future<Either<Failure, void>> removeConnectedCalendar(String provider);

  /// 설정 초기화
  Future<Either<Failure, UserSettings>> resetToDefaults();

  /// 데이터 내보내기
  Future<Either<Failure, String>> exportUserData();

  /// 데이터 삭제 (계정 삭제 시)
  Future<Either<Failure, void>> deleteAllData();

  /// 설정 스트림 (실시간 업데이트)
  Stream<Either<Failure, UserSettings>> watchSettings();
}
