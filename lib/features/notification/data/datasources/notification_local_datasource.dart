import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../domain/entities/notification_settings.dart';

/// 알림 설정 로컬 데이터소스
///
/// SharedPreferences를 사용하여 알림 설정 저장/로드
class NotificationLocalDataSource {
  static const String _settingsKey = 'notification_settings';
  static const String _lastAppOpenKey = 'last_app_open_date';

  final SharedPreferences _prefs;

  NotificationLocalDataSource(this._prefs);

  /// 알림 설정 가져오기
  NotificationSettings getSettings() {
    final jsonString = _prefs.getString(_settingsKey);
    if (jsonString == null) {
      return NotificationSettings.defaults();
    }

    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return NotificationSettings.fromJson(json);
    } catch (e) {
      return NotificationSettings.defaults();
    }
  }

  /// 알림 설정 저장
  Future<void> saveSettings(NotificationSettings settings) async {
    final jsonString = jsonEncode(settings.toJson());
    await _prefs.setString(_settingsKey, jsonString);
  }

  /// 마지막 앱 오픈 날짜 가져오기
  String? getLastAppOpenDate() {
    return _prefs.getString(_lastAppOpenKey);
  }

  /// 마지막 앱 오픈 날짜 저장
  Future<void> setLastAppOpenDate(String dateString) async {
    await _prefs.setString(_lastAppOpenKey, dateString);
  }

  /// 오늘 앱을 열었는지 확인
  bool hasOpenedAppToday() {
    final lastOpenDate = getLastAppOpenDate();
    if (lastOpenDate == null) return false;

    final today = DateTime.now();
    final todayString =
        '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    return lastOpenDate == todayString;
  }

  /// 오늘 앱 오픈 기록
  Future<void> recordAppOpenToday() async {
    final today = DateTime.now();
    final todayString =
        '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
    await setLastAppOpenDate(todayString);
  }
}
