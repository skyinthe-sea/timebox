import 'package:flutter/material.dart';
import 'config/themes/app_theme.dart';

/// Timebox Planner 앱의 루트 위젯
///
/// MaterialApp 설정:
/// - 테마 (라이트/다크 모드)
/// - 라우팅
/// - 다국어 (l10n)
/// - 디버그 배너 제거
class TimeboxApp extends StatelessWidget {
  const TimeboxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timebox Planner',
      debugShowCheckedModeBanner: false,

      // 테마 설정
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      // TODO: 라우터 설정
      // routerConfig: appRouter,

      // TODO: 다국어 설정
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,

      home: const Scaffold(
        body: Center(
          child: Text('Timebox Planner'),
        ),
      ),
    );
  }
}
