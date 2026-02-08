import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/app_localizations.dart';
import 'ad_banner.dart';

/// 메인 셸 위젯
///
/// BottomNavigationBar를 포함한 앱의 기본 레이아웃
/// StatefulShellRoute와 함께 사용되어 각 탭의 상태를 보존
class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        children: [
          // 광고 배너 (최상단)
          const SafeArea(
            bottom: false,
            child: AdBanner(),
          ),
          // 메인 콘텐츠
          Expanded(child: navigationShell),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) =>
            navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.view_agenda_outlined),
            selectedIcon: const Icon(Icons.view_agenda),
            label: l10n?.planner ?? 'Timebox',
          ),
          NavigationDestination(
            icon: const Icon(Icons.calendar_today_outlined),
            selectedIcon: const Icon(Icons.calendar_today),
            label: l10n?.navTimeline ?? 'Timeline',
          ),
          NavigationDestination(
            icon: const Icon(Icons.bar_chart_outlined),
            selectedIcon: const Icon(Icons.bar_chart),
            label: l10n?.navReport ?? 'Report',
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
}
