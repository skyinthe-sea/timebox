import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

/// 알림 ID 생성기
///
/// TimeBlock ID(UUID)를 기반으로 일관된 정수 ID 생성
class NotificationIdGenerator {
  /// 타임블록 시작 알람 ID
  static int forTimeBlockStart(String timeBlockId, int minutesBefore) {
    return 'tb_start_${timeBlockId}_$minutesBefore'.hashCode.abs() % 2147483647;
  }

  /// 타임블록 종료 알람 ID
  static int forTimeBlockEnd(String timeBlockId, int minutesBefore) {
    return 'tb_end_${timeBlockId}_$minutesBefore'.hashCode.abs() % 2147483647;
  }

  /// 일일 참여 알림 ID (고정)
  static const int dailyEngagement = 999999999;
}

/// 알림 서비스
///
/// flutter_local_notifications 래퍼
/// 알림 스케줄링, 취소, 권한 관리
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  /// 알림 서비스 사용 가능 여부
  bool get isAvailable => _isInitialized;

  /// 서비스 초기화
  ///
  /// 앱 시작 시 main()에서 호출
  Future<void> initialize() async {
    if (_isInitialized) return;

    // 타임존 초기화
    tz.initializeTimeZones();
    try {
      final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(currentTimeZone));
    } catch (e) {
      // 시뮬레이터나 플러그인 미지원 환경에서는 기본 타임존 사용
      debugPrint('FlutterTimezone failed, using fallback: $e');
      tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
    }

    // Android 설정
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS 설정
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    try {
      await _plugin.initialize(
        initSettings,
        onDidReceiveNotificationResponse: _onNotificationTapped,
      );
      _isInitialized = true;
    } catch (e) {
      // Hot restart 또는 시뮬레이터에서 네이티브 플러그인 미지원
      debugPrint('NotificationService initialization failed: $e');
      debugPrint('Notifications will be disabled for this session.');
    }
  }

  /// 알림 탭 핸들러
  void _onNotificationTapped(NotificationResponse response) {
    // TODO: 알림 탭 시 특정 화면으로 이동
    debugPrint('Notification tapped: ${response.payload}');
  }

  /// 권한 요청
  ///
  /// Android 13+, iOS 모두 처리
  /// 반환: 권한 허용 여부
  Future<bool> requestPermissions() async {
    if (!_isInitialized) return false;

    if (Platform.isAndroid) {
      // Android 13+ (API 33+) POST_NOTIFICATIONS
      final notificationStatus = await Permission.notification.request();

      // Exact alarm permission (Android 12+)
      await Permission.scheduleExactAlarm.request();

      return notificationStatus.isGranted;
    } else if (Platform.isIOS) {
      final result = await _plugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      return result ?? false;
    }
    return false;
  }

  /// 권한 상태 확인
  Future<bool> hasPermissions() async {
    if (!_isInitialized) return false;

    if (Platform.isAndroid) {
      return await Permission.notification.isGranted;
    } else if (Platform.isIOS) {
      final result = await _plugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.checkPermissions();
      return result?.isEnabled ?? false;
    }
    return false;
  }

  /// 알림 스케줄링
  ///
  /// [id] 고유 알림 ID
  /// [title] 알림 제목
  /// [body] 알림 본문
  /// [scheduledTime] 알림 시간
  /// [payload] 추가 데이터 (JSON)
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    String? payload,
  }) async {
    if (!_isInitialized) return;

    // 과거 시간이면 스케줄링하지 않음
    if (scheduledTime.isBefore(DateTime.now())) {
      debugPrint('Skipping past notification: $scheduledTime');
      return;
    }

    final androidDetails = AndroidNotificationDetails(
      'timebox_alarms',
      'Timebox Alarms',
      channelDescription: 'Timebox timeblock alarm notifications',
      importance: Importance.high,
      priority: Priority.high,
      enableVibration: true,
      playSound: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      details,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );

    debugPrint('Scheduled notification: id=$id, time=$scheduledTime');
  }

  /// 특정 알림 취소
  Future<void> cancelNotification(int id) async {
    if (!_isInitialized) return;

    await _plugin.cancel(id);
    debugPrint('Cancelled notification: id=$id');
  }

  /// 특정 태그의 모든 알림 취소 (태그 기반은 지원 안 함, ID 목록으로 처리)
  Future<void> cancelNotifications(List<int> ids) async {
    for (final id in ids) {
      await cancelNotification(id);
    }
  }

  /// 모든 알림 취소
  Future<void> cancelAllNotifications() async {
    if (!_isInitialized) return;

    await _plugin.cancelAll();
    debugPrint('Cancelled all notifications');
  }

  /// 대기 중인 알림 조회
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    if (!_isInitialized) return [];

    return await _plugin.pendingNotificationRequests();
  }

  /// 타임블록 관련 알림 ID 목록 생성
  ///
  /// 시작/종료 알람 모든 타이밍에 대한 ID 목록 반환
  List<int> getTimeBlockNotificationIds(
    String timeBlockId,
    List<int> minutesBeforeStart,
    List<int> minutesBeforeEnd,
  ) {
    final ids = <int>[];

    for (final minutes in minutesBeforeStart) {
      ids.add(NotificationIdGenerator.forTimeBlockStart(timeBlockId, minutes));
    }

    for (final minutes in minutesBeforeEnd) {
      ids.add(NotificationIdGenerator.forTimeBlockEnd(timeBlockId, minutes));
    }

    return ids;
  }
}
