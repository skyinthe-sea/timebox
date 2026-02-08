import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/main_shell.dart';
import '../../features/analytics/presentation/pages/statistics_page.dart';
import '../../features/focus/presentation/pages/focus_mode_page.dart';
import '../../features/planner/presentation/pages/planner_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/timeblock/presentation/pages/calendar_page.dart';
import 'route_names.dart';

/// 앱 라우터 설정
///
/// go_router를 사용한 선언적 라우팅 설정
///
/// 주요 라우트:
/// - / : 홈 (플래너 뷰 - Top 3, 브레인덤프, 타임라인)
/// - /calendar : 캘린더 (기존 타임블록 뷰)
/// - /focus : 포커스 모드
/// - /settings : 설정
class AppRouter {
  AppRouter._();

  // Navigator keys
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteNames.home,
    debugLogDiagnostics: false,
    routes: [
      // StatefulShellRoute: 각 탭의 위젯 상태를 보존 (날짜 등)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainShell(navigationShell: navigationShell),
        branches: [
          // 홈 (플래너)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.home,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: PlannerPage(),
                ),
              ),
            ],
          ),
          // 캘린더 (기존 타임블록 뷰)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.calendar,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: CalendarPage(),
                ),
              ),
            ],
          ),
          // 통계 (app.dart에서 전역 BlocProvider로 제공)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.statistics,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: StatisticsPage(),
                ),
              ),
            ],
          ),
          // 설정
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.settings,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: SettingsPage(),
                ),
              ),
            ],
          ),
        ],
      ),
      // 포커스 모드 (풀스크린)
      GoRoute(
        path: RouteNames.focus,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          return FocusModePage(
            timeBlockId: state.uri.queryParameters['timeBlockId'],
          );
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri.path}'),
      ),
    ),
  );
}
