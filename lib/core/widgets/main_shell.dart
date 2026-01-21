import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/routes/route_names.dart';
import '../../l10n/app_localizations.dart';

/// 메인 셸 위젯
///
/// BottomNavigationBar를 포함한 앱의 기본 레이아웃
/// ShellRoute와 함께 사용되어 하단 네비게이션을 제공
class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (index) => _onItemTapped(context, index),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.view_agenda_outlined),
            selectedIcon: const Icon(Icons.view_agenda),
            label: l10n?.appName ?? 'Planner',
          ),
          NavigationDestination(
            icon: const Icon(Icons.calendar_today_outlined),
            selectedIcon: const Icon(Icons.calendar_today),
            label: l10n?.calendar ?? 'Calendar',
          ),
          NavigationDestination(
            icon: const Icon(Icons.timer_outlined),
            selectedIcon: const Icon(Icons.timer),
            label: l10n?.focus ?? 'Focus',
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: l10n?.settings ?? 'Settings',
          ),
        ],
        backgroundColor: theme.colorScheme.surface,
        indicatorColor: theme.colorScheme.primaryContainer,
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    if (location == RouteNames.home) return 0;
    if (location == RouteNames.calendar) return 1;
    if (location == RouteNames.focus) return 2;
    if (location == RouteNames.settings) return 3;

    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(RouteNames.home);
        break;
      case 1:
        context.go(RouteNames.calendar);
        break;
      case 2:
        context.go(RouteNames.focus);
        break;
      case 3:
        context.go(RouteNames.settings);
        break;
    }
  }
}
