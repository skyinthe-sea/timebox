import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../timeblock/domain/entities/time_block.dart';
import '../entities/notification_settings.dart';

/// 알림 레포지토리 인터페이스
///
/// 알림 스케줄링, 취소, 설정 관리
abstract class NotificationRepository {
  /// 알림 설정 가져오기
  Future<Either<Failure, NotificationSettings>> getSettings();

  /// 알림 설정 저장
  Future<Either<Failure, void>> saveSettings(NotificationSettings settings);

  /// 타임블록 알림 스케줄링
  ///
  /// 시작/종료 전 알람을 설정에 따라 예약
  /// [timeBlock] 알람을 설정할 타임블록
  /// [taskTitle] 알림에 표시할 태스크 제목
  Future<Either<Failure, void>> scheduleTimeBlockAlarms(
    TimeBlock timeBlock, {
    String? taskTitle,
  });

  /// 타임블록 알림 취소
  ///
  /// 해당 타임블록의 모든 알림 취소
  Future<Either<Failure, void>> cancelTimeBlockAlarms(String timeBlockId);

  /// 일일 리마인더 스케줄링
  ///
  /// 오늘 타임블록이 없으면 내일 지정 시간에 알림
  /// [hasTimeBlocksToday] 오늘 계획이 있는지 여부
  Future<Either<Failure, void>> scheduleDailyReminder({
    required bool hasTimeBlocksToday,
  });

  /// 일일 리마인더 취소
  Future<Either<Failure, void>> cancelDailyReminder();

  /// 모든 알림 취소
  Future<Either<Failure, void>> cancelAllNotifications();

  /// 권한 요청
  ///
  /// 반환: 권한 허용 여부
  Future<Either<Failure, bool>> requestPermissions();

  /// 권한 상태 확인
  Future<Either<Failure, bool>> hasPermissions();
}
