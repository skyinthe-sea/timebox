import 'package:flutter/material.dart';

/// 설정 페이지
///
/// 앱 설정 관리 화면
///
/// 섹션:
/// - 테마 설정
/// - 언어 설정
/// - 알림 설정
/// - 캘린더 연동
/// - 시간 설정
/// - 데이터 관리
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // TODO: BlocProvider, BlocBuilder 구현
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'), // TODO: l10n
      ),
      body: ListView(
        children: [
          // 외관 섹션
          _buildSectionHeader(theme, '외관'), // TODO: l10n
          _buildThemeTile(context),
          _buildLanguageTile(context),

          const Divider(),

          // 알림 섹션
          _buildSectionHeader(theme, '알림'), // TODO: l10n
          _buildNotificationTile(context),
          _buildNotificationTimingTile(context),

          const Divider(),

          // 캘린더 섹션
          _buildSectionHeader(theme, '캘린더'), // TODO: l10n
          _buildCalendarSyncTile(context),

          const Divider(),

          // 시간 설정 섹션
          _buildSectionHeader(theme, '시간 설정'), // TODO: l10n
          _buildDayTimeTile(context),
          _buildDefaultDurationTile(context),

          const Divider(),

          // 데이터 섹션
          _buildSectionHeader(theme, '데이터'), // TODO: l10n
          _buildExportTile(context),
          _buildResetTile(context),

          const SizedBox(height: 24),

          // 앱 정보
          Center(
            child: Text(
              'Timebox Planner v1.0.0',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildThemeTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.palette_outlined),
      title: const Text('테마'), // TODO: l10n
      subtitle: const Text('시스템 설정'), // TODO: 현재 설정값
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // TODO: 테마 선택 다이얼로그
      },
    );
  }

  Widget _buildLanguageTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.language),
      title: const Text('언어'), // TODO: l10n
      subtitle: const Text('한국어'), // TODO: 현재 설정값
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // TODO: 언어 선택 다이얼로그
      },
    );
  }

  Widget _buildNotificationTile(BuildContext context) {
    return SwitchListTile(
      secondary: const Icon(Icons.notifications_outlined),
      title: const Text('알림'), // TODO: l10n
      subtitle: const Text('타임박스 알림 받기'), // TODO: l10n
      value: true, // TODO: 실제 설정값
      onChanged: (value) {
        // TODO: 설정 변경
      },
    );
  }

  Widget _buildNotificationTimingTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.timer_outlined),
      title: const Text('알림 시간'), // TODO: l10n
      subtitle: const Text('시작 5분 전, 종료 5분 전'), // TODO: 현재 설정값
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // TODO: 알림 시간 설정 다이얼로그
      },
    );
  }

  Widget _buildCalendarSyncTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.calendar_month_outlined),
      title: const Text('캘린더 연동'), // TODO: l10n
      subtitle: const Text('연결된 캘린더 없음'), // TODO: 현재 상태
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // TODO: 캘린더 설정 페이지로 이동
      },
    );
  }

  Widget _buildDayTimeTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.schedule_outlined),
      title: const Text('하루 시간 범위'), // TODO: l10n
      subtitle: const Text('06:00 - 24:00'), // TODO: 현재 설정값
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // TODO: 시간 범위 설정 다이얼로그
      },
    );
  }

  Widget _buildDefaultDurationTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.timelapse_outlined),
      title: const Text('기본 타임박스 길이'), // TODO: l10n
      subtitle: const Text('30분'), // TODO: 현재 설정값
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // TODO: 기본 길이 설정 다이얼로그
      },
    );
  }

  Widget _buildExportTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.download_outlined),
      title: const Text('데이터 내보내기'), // TODO: l10n
      subtitle: const Text('CSV 파일로 내보내기'), // TODO: l10n
      onTap: () {
        // TODO: 내보내기 처리
      },
    );
  }

  Widget _buildResetTile(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.restore,
        color: Theme.of(context).colorScheme.error,
      ),
      title: Text(
        '설정 초기화', // TODO: l10n
        style: TextStyle(
          color: Theme.of(context).colorScheme.error,
        ),
      ),
      onTap: () {
        // TODO: 초기화 확인 다이얼로그
      },
    );
  }
}
