import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 데모 모드 서비스
///
/// 앱스토어 스크린샷용 샘플 데이터 관리
/// SharedPreferences로 데모 모드 상태 저장
class DemoModeService extends ChangeNotifier {
  static const String _kDemoModeEnabled = 'demo_mode_enabled';
  static const String _kDemoDataGenerated = 'demo_data_generated_locale';

  final SharedPreferences _prefs;

  bool _isEnabled = false;
  String? _generatedLocale;

  DemoModeService(this._prefs) {
    _loadState();
  }

  /// 데모 모드 활성화 여부
  bool get isEnabled => _isEnabled;

  /// 현재 생성된 데모 데이터의 로케일
  String? get generatedLocale => _generatedLocale;

  /// 데모 데이터 ID prefix
  static const String demoPrefix = 'demo_';

  /// ID가 데모 데이터인지 확인
  static bool isDemoId(String id) => id.startsWith(demoPrefix);

  /// 데모 ID 생성
  static String createDemoId(String suffix) => '$demoPrefix$suffix';

  void _loadState() {
    _isEnabled = _prefs.getBool(_kDemoModeEnabled) ?? false;
    _generatedLocale = _prefs.getString(_kDemoDataGenerated);
  }

  /// 데모 모드 활성화
  Future<void> enable() async {
    _isEnabled = true;
    await _prefs.setBool(_kDemoModeEnabled, true);
    notifyListeners();
  }

  /// 데모 모드 비활성화
  Future<void> disable() async {
    _isEnabled = false;
    _generatedLocale = null;
    await _prefs.setBool(_kDemoModeEnabled, false);
    await _prefs.remove(_kDemoDataGenerated);
    notifyListeners();
  }

  /// 데모 데이터 생성 완료 표시
  Future<void> markDataGenerated(String locale) async {
    _generatedLocale = locale;
    await _prefs.setString(_kDemoDataGenerated, locale);
  }

  /// 데모 데이터 재생성 필요 여부 (로케일 변경 시)
  bool needsRegeneration(String currentLocale) {
    if (!_isEnabled) return false;
    return _generatedLocale != currentLocale;
  }
}
