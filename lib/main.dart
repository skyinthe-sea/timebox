import 'package:flutter/material.dart';
import 'app.dart';
import 'injection_container.dart' as di;

/// Timebox Planner 앱 진입점
///
/// 앱 시작 시 수행되는 작업:
/// 1. Flutter 엔진 바인딩 초기화
/// 2. 의존성 주입 초기화
/// 3. 앱 실행
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 의존성 주입 초기화
  await di.init();

  runApp(const TimeboxApp());
}
