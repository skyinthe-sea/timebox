import 'package:flutter/material.dart';
import 'app.dart';
import 'core/services/hive_service.dart';
import 'injection_container.dart' as di;

/// Timebox Planner 앱 진입점
///
/// 앱 시작 시 수행되는 작업:
/// 1. Flutter 엔진 바인딩 초기화
/// 2. Hive 로컬 스토리지 초기화
/// 3. 의존성 주입 초기화
/// 4. 앱 실행
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive 초기화
  await HiveService.init();
  await HiveService.openBoxes();

  // 의존성 주입 초기화
  await di.init();

  runApp(const TimeboxApp());
}
