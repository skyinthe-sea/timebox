import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../cubit/settings_cubit.dart';

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
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.settings),
          ),
          body: ListView(
            children: [
              // 외관 섹션
              _buildSectionHeader(theme, l10n.appearance),
              _buildThemeTile(context, state, l10n),
              _buildLanguageTile(context, state, l10n),

              const Divider(),

              // 알림 섹션
              _buildSectionHeader(theme, l10n.notifications),
              _buildNotificationTile(context, state, l10n),
              _buildNotificationTimingTile(context, state, l10n),

              const Divider(),

              // 캘린더 섹션
              _buildSectionHeader(theme, l10n.calendarSync),
              _buildCalendarSyncTile(context, l10n),

              const Divider(),

              // 시간 설정 섹션
              _buildSectionHeader(theme, l10n.timeSettings),
              _buildDayTimeTile(context, state, l10n),
              _buildDefaultDurationTile(context, state, l10n),

              const Divider(),

              // 데이터 섹션
              _buildSectionHeader(theme, l10n.data),
              _buildExportTile(context, l10n),
              _buildResetTile(context, l10n),

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
      },
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

  Widget _buildThemeTile(
    BuildContext context,
    SettingsState state,
    AppLocalizations l10n,
  ) {
    return ListTile(
      leading: const Icon(Icons.palette_outlined),
      title: Text(l10n.theme),
      subtitle: Text(_getThemeText(state.themeMode, l10n)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _showThemeDialog(context, state, l10n),
    );
  }

  String _getThemeText(ThemeMode mode, AppLocalizations l10n) {
    switch (mode) {
      case ThemeMode.system:
        return l10n.themeSystem;
      case ThemeMode.light:
        return l10n.themeLight;
      case ThemeMode.dark:
        return l10n.themeDark;
    }
  }

  void _showThemeDialog(
    BuildContext context,
    SettingsState state,
    AppLocalizations l10n,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: Text(l10n.theme),
        children: [
          RadioListTile<ThemeMode>(
            title: Text(l10n.themeSystem),
            value: ThemeMode.system,
            groupValue: state.themeMode,
            onChanged: (value) {
              context.read<SettingsCubit>().setThemeMode(value!);
              Navigator.pop(dialogContext);
            },
          ),
          RadioListTile<ThemeMode>(
            title: Text(l10n.themeLight),
            value: ThemeMode.light,
            groupValue: state.themeMode,
            onChanged: (value) {
              context.read<SettingsCubit>().setThemeMode(value!);
              Navigator.pop(dialogContext);
            },
          ),
          RadioListTile<ThemeMode>(
            title: Text(l10n.themeDark),
            value: ThemeMode.dark,
            groupValue: state.themeMode,
            onChanged: (value) {
              context.read<SettingsCubit>().setThemeMode(value!);
              Navigator.pop(dialogContext);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageTile(
    BuildContext context,
    SettingsState state,
    AppLocalizations l10n,
  ) {
    return ListTile(
      leading: const Icon(Icons.language),
      title: Text(l10n.language),
      subtitle: Text(state.localeText),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _showLanguageDialog(context, state, l10n),
    );
  }

  void _showLanguageDialog(
    BuildContext context,
    SettingsState state,
    AppLocalizations l10n,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: Text(l10n.language),
        children: supportedLocales.map((locale) {
          return RadioListTile<Locale>(
            title: Text(_getLocaleDisplayName(locale)),
            value: locale,
            groupValue: state.locale,
            onChanged: (value) {
              context.read<SettingsCubit>().setLocale(value!);
              Navigator.pop(dialogContext);
            },
          );
        }).toList(),
      ),
    );
  }

  String _getLocaleDisplayName(Locale locale) {
    switch (locale.languageCode) {
      case 'ko':
        return '한국어';
      case 'en':
        return 'English';
      case 'ja':
        return '日本語';
      case 'hi':
        return 'हिन्दी';
      case 'zh':
        return '中文';
      case 'fr':
        return 'Français';
      case 'de':
        return 'Deutsch';
      default:
        return locale.languageCode;
    }
  }

  Widget _buildNotificationTile(
    BuildContext context,
    SettingsState state,
    AppLocalizations l10n,
  ) {
    return SwitchListTile(
      secondary: const Icon(Icons.notifications_outlined),
      title: Text(l10n.notifications),
      subtitle: Text(l10n.notificationDescription),
      value: state.notificationsEnabled,
      onChanged: (value) {
        context.read<SettingsCubit>().setNotificationsEnabled(value);
      },
    );
  }

  Widget _buildNotificationTimingTile(
    BuildContext context,
    SettingsState state,
    AppLocalizations l10n,
  ) {
    return ListTile(
      leading: const Icon(Icons.timer_outlined),
      title: Text(l10n.notificationTiming),
      subtitle: Text(l10n.minutesBefore(state.notificationBeforeMinutes)),
      trailing: const Icon(Icons.chevron_right),
      enabled: state.notificationsEnabled,
      onTap: state.notificationsEnabled
          ? () => _showNotificationTimingDialog(context, state, l10n)
          : null,
    );
  }

  void _showNotificationTimingDialog(
    BuildContext context,
    SettingsState state,
    AppLocalizations l10n,
  ) {
    final timingOptions = [1, 3, 5, 10, 15, 30];

    showDialog(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: Text(l10n.notificationTiming),
        children: timingOptions.map((minutes) {
          return RadioListTile<int>(
            title: Text(l10n.minutesBefore(minutes)),
            value: minutes,
            groupValue: state.notificationBeforeMinutes,
            onChanged: (value) {
              context.read<SettingsCubit>().setNotificationBeforeMinutes(value!);
              Navigator.pop(dialogContext);
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCalendarSyncTile(BuildContext context, AppLocalizations l10n) {
    return ListTile(
      leading: const Icon(Icons.calendar_month_outlined),
      title: Text(l10n.calendarSync),
      subtitle: Text(l10n.noCalendarConnected),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // TODO: 캘린더 설정 페이지로 이동
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.comingSoon)),
        );
      },
    );
  }

  Widget _buildDayTimeTile(
    BuildContext context,
    SettingsState state,
    AppLocalizations l10n,
  ) {
    final startTime = '${state.dayStartHour.toString().padLeft(2, '0')}:00';
    final endTime = state.dayEndHour == 24
        ? '24:00'
        : '${state.dayEndHour.toString().padLeft(2, '0')}:00';

    return ListTile(
      leading: const Icon(Icons.schedule_outlined),
      title: Text(l10n.dayTimeRange),
      subtitle: Text('$startTime - $endTime'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _showDayTimeDialog(context, state, l10n),
    );
  }

  void _showDayTimeDialog(
    BuildContext context,
    SettingsState state,
    AppLocalizations l10n,
  ) {
    int startHour = state.dayStartHour;
    int endHour = state.dayEndHour;

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(l10n.dayTimeRange),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(l10n.dayStartTime),
                trailing: DropdownButton<int>(
                  value: startHour,
                  items: List.generate(24, (i) => i).map((hour) {
                    return DropdownMenuItem(
                      value: hour,
                      child: Text('${hour.toString().padLeft(2, '0')}:00'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null && value < endHour) {
                      setState(() => startHour = value);
                    }
                  },
                ),
              ),
              ListTile(
                title: Text(l10n.dayEndTime),
                trailing: DropdownButton<int>(
                  value: endHour,
                  items: List.generate(25, (i) => i)
                      .where((h) => h > startHour)
                      .map((hour) {
                    return DropdownMenuItem(
                      value: hour,
                      child: Text(hour == 24
                          ? '24:00'
                          : '${hour.toString().padLeft(2, '0')}:00'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => endHour = value);
                    }
                  },
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(l10n.cancel),
            ),
            TextButton(
              onPressed: () {
                context.read<SettingsCubit>().setDayStartHour(startHour);
                context.read<SettingsCubit>().setDayEndHour(endHour);
                Navigator.pop(dialogContext);
              },
              child: Text(l10n.confirm),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultDurationTile(
    BuildContext context,
    SettingsState state,
    AppLocalizations l10n,
  ) {
    return ListTile(
      leading: const Icon(Icons.timelapse_outlined),
      title: Text(l10n.defaultTimeBlockDuration),
      subtitle: Text(l10n.minutesShort(state.defaultTimeBlockMinutes)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _showDefaultDurationDialog(context, state, l10n),
    );
  }

  void _showDefaultDurationDialog(
    BuildContext context,
    SettingsState state,
    AppLocalizations l10n,
  ) {
    final durationOptions = [15, 30, 45, 60, 90];

    showDialog(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: Text(l10n.defaultTimeBlockDuration),
        children: durationOptions.map((minutes) {
          return RadioListTile<int>(
            title: Text(l10n.minutesShort(minutes)),
            value: minutes,
            groupValue: state.defaultTimeBlockMinutes,
            onChanged: (value) {
              context.read<SettingsCubit>().setDefaultDuration(value!);
              Navigator.pop(dialogContext);
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildExportTile(BuildContext context, AppLocalizations l10n) {
    return ListTile(
      leading: const Icon(Icons.download_outlined),
      title: Text(l10n.exportData),
      subtitle: Text(l10n.exportDataDescription),
      onTap: () {
        // TODO: 내보내기 처리
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.comingSoon)),
        );
      },
    );
  }

  Widget _buildResetTile(BuildContext context, AppLocalizations l10n) {
    return ListTile(
      leading: Icon(
        Icons.restore,
        color: Theme.of(context).colorScheme.error,
      ),
      title: Text(
        l10n.resetSettings,
        style: TextStyle(
          color: Theme.of(context).colorScheme.error,
        ),
      ),
      onTap: () => _showResetConfirmDialog(context, l10n),
    );
  }

  void _showResetConfirmDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.resetSettings),
        content: Text(l10n.resetSettingsConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              context.read<SettingsCubit>().resetToDefaults();
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.settingsReset)),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(l10n.confirm),
          ),
        ],
      ),
    );
  }
}
