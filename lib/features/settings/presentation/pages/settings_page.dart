import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_constants.dart';
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
        return Column(
          children: [
            // 헤더
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Text(
                  l10n.settings,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            // 콘텐츠
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // 외관 섹션
                  _buildSectionHeader(theme, l10n.appearance),
                  _buildThemeTile(context, state, l10n),
                  _buildLanguageTile(context, state, l10n),
                  const Divider(),
                  // 알림 섹션
                  _buildSectionHeader(theme, l10n.notifications),
                  _buildNotificationMasterTile(context, state, l10n),
                  if (!state.hasNotificationPermission && state.notificationsEnabled)
                    _buildPermissionWarningTile(context, l10n),
                  if (state.notificationsEnabled) ...[
                    _buildStartAlarmSection(context, state, l10n, theme),
                    _buildEndAlarmSection(context, state, l10n, theme),
                    const SizedBox(height: 8),
                    _buildDailyReminderSection(context, state, l10n, theme),
                  ],
                  const Divider(),
                  // 시간 설정 섹션
                  _buildSectionHeader(theme, l10n.timeSettings),
                  _buildDayTimeTile(context, state, l10n),
                  _buildDefaultDurationTile(context, state, l10n),
                  const Divider(),
                  // 데이터 섹션
                  _buildSectionHeader(theme, l10n.data),
                  _buildResetTile(context, l10n),
                  const SizedBox(height: 24),
                  // 앱 정보
                  Center(
                    child: Text(
                      'Timebox Planner v${AppConstants.appVersion}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // 법적 정보 링크
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => _showLegalSheet(
                          context,
                          l10n.privacyPolicy,
                          l10n.privacyPolicyContent,
                        ),
                        child: Text(
                          l10n.privacyPolicy,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.outline,
                            decoration: TextDecoration.underline,
                            decorationColor: theme.colorScheme.outline,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          '·',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showLegalSheet(
                          context,
                          l10n.termsOfService,
                          l10n.termsOfServiceContent,
                        ),
                        child: Text(
                          l10n.termsOfService,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.outline,
                            decoration: TextDecoration.underline,
                            decorationColor: theme.colorScheme.outline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
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

  Widget _buildNotificationMasterTile(
    BuildContext context,
    SettingsState state,
    AppLocalizations l10n,
  ) {
    return SwitchListTile(
      secondary: const Icon(Icons.notifications_outlined),
      title: Text(l10n.notifications),
      subtitle: Text(l10n.notificationDescription),
      value: state.notificationsEnabled,
      onChanged: (value) async {
        final cubit = context.read<SettingsCubit>();
        if (value && !state.hasNotificationPermission) {
          final granted = await cubit.requestNotificationPermissions();
          if (!granted) return;
        }
        cubit.setNotificationsEnabled(value);
      },
    );
  }

  Widget _buildPermissionWarningTile(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Theme.of(context).colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: Theme.of(context).colorScheme.onErrorContainer,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                l10n.notificationPermissionRequired,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<SettingsCubit>().requestNotificationPermissions();
              },
              child: Text(l10n.requestPermission),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStartAlarmSection(
    BuildContext context,
    SettingsState state,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          secondary: const Icon(Icons.play_circle_outline),
          title: Text(l10n.startAlarm),
          subtitle: Text(l10n.notifyBeforeStart),
          value: state.startAlarmEnabled,
          onChanged: (value) {
            context.read<SettingsCubit>().setStartAlarmEnabled(value);
          },
        ),
        if (state.startAlarmEnabled)
          Padding(
            padding: const EdgeInsets.only(left: 72, right: 16, bottom: 8),
            child: _buildTimingChips(
              context,
              state.minutesBeforeStart,
              (selected) {
                context.read<SettingsCubit>().setMinutesBeforeStart(selected);
              },
              l10n,
            ),
          ),
      ],
    );
  }

  Widget _buildEndAlarmSection(
    BuildContext context,
    SettingsState state,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          secondary: const Icon(Icons.stop_circle_outlined),
          title: Text(l10n.endAlarm),
          subtitle: Text(l10n.notifyBeforeEnd),
          value: state.endAlarmEnabled,
          onChanged: (value) {
            context.read<SettingsCubit>().setEndAlarmEnabled(value);
          },
        ),
        if (state.endAlarmEnabled)
          Padding(
            padding: const EdgeInsets.only(left: 72, right: 16, bottom: 8),
            child: _buildTimingChips(
              context,
              state.minutesBeforeEnd,
              (selected) {
                context.read<SettingsCubit>().setMinutesBeforeEnd(selected);
              },
              l10n,
            ),
          ),
      ],
    );
  }

  Widget _buildTimingChips(
    BuildContext context,
    List<int> selected,
    ValueChanged<List<int>> onChanged,
    AppLocalizations l10n,
  ) {
    const options = [5, 10, 15, 30, 60];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((minutes) {
        final isSelected = selected.contains(minutes);
        final label = minutes >= 60
            ? l10n.hourBefore(minutes ~/ 60)
            : l10n.minutesBefore(minutes);

        return FilterChip(
          label: Text(label),
          selected: isSelected,
          onSelected: (newValue) {
            final newList = List<int>.from(selected);
            if (newValue) {
              newList.add(minutes);
            } else {
              if (newList.length > 1) {
                newList.remove(minutes);
              }
            }
            onChanged(newList..sort());
          },
        );
      }).toList(),
    );
  }

  Widget _buildDailyReminderSection(
    BuildContext context,
    SettingsState state,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    final timeString =
        '${state.dailyReminderHour.toString().padLeft(2, '0')}:${state.dailyReminderMinute.toString().padLeft(2, '0')}';

    return Column(
      children: [
        SwitchListTile(
          secondary: const Icon(Icons.calendar_today_outlined),
          title: Text(l10n.dailyReminder),
          subtitle: Text(l10n.dailyReminderDesc),
          value: state.dailyReminderEnabled,
          onChanged: (value) {
            context.read<SettingsCubit>().setDailyReminderEnabled(value);
          },
        ),
        if (state.dailyReminderEnabled)
          ListTile(
            leading: const SizedBox(width: 24),
            title: Text(l10n.dailyReminderTime),
            subtitle: Text(timeString),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showDailyReminderTimeDialog(context, state, l10n),
          ),
      ],
    );
  }

  void _showDailyReminderTimeDialog(
    BuildContext context,
    SettingsState state,
    AppLocalizations l10n,
  ) async {
    final cubit = context.read<SettingsCubit>();
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: state.dailyReminderHour,
        minute: state.dailyReminderMinute,
      ),
    );

    if (time != null) {
      cubit.setDailyReminderTime(time.hour, time.minute);
    }
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

  void _showLegalSheet(BuildContext context, String title, String content) {
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.outline.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: Text(
                  content,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.6,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
