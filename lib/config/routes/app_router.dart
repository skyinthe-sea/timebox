import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/main_shell.dart';
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
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteNames.home,
    debugLogDiagnostics: true,
    routes: [
      // ShellRoute for bottom navigation
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          // 홈 (플래너)
          GoRoute(
            path: RouteNames.home,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: PlannerPage(),
            ),
          ),
          // 캘린더 (기존 타임블록 뷰)
          GoRoute(
            path: RouteNames.calendar,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CalendarPage(),
            ),
          ),
          // 포커스
          GoRoute(
            path: RouteNames.focus,
            pageBuilder: (context, state) => NoTransitionPage(
              child: FocusModePage(
                timeBlockId: state.uri.queryParameters['timeBlockId'],
              ),
            ),
          ),
          // 설정
          GoRoute(
            path: RouteNames.settings,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SettingsPage(),
            ),
          ),
        ],
      ),
      // Task 상세 (모달 또는 풀스크린)
      GoRoute(
        path: '/task/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final taskId = state.pathParameters['id']!;
          // TODO: TaskDetailPage 구현 후 연결
          return Scaffold(
            appBar: AppBar(title: Text('Task: $taskId')),
            body: Center(child: Text('Task Detail: $taskId')),
          );
        },
      ),
      // Task 생성
      GoRoute(
        path: RouteNames.taskCreate,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          // TODO: TaskCreatePage 구현 후 연결
          return Scaffold(
            appBar: AppBar(title: const Text('New Task')),
            body: const Center(child: Text('Create Task')),
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
