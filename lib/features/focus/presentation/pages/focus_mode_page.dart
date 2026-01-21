import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/focus_bloc.dart';

/// 포커스 모드 페이지
///
/// 현재 진행 중인 타임박스에 대한 집중 화면
class FocusModePage extends StatelessWidget {
  final String? timeBlockId;

  const FocusModePage({
    super.key,
    this.timeBlockId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<FocusBloc, FocusState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.colorScheme.surface,
          appBar: AppBar(
            title: Text(l10n?.focusMode ?? 'Focus Mode'),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SafeArea(
            child: state.hasActiveSession
                ? _buildActiveSession(context, state, theme, l10n, isDark)
                : _buildIdleState(context, state, theme, l10n),
          ),
        );
      },
    );
  }

  Widget _buildIdleState(
    BuildContext context,
    FocusState state,
    ThemeData theme,
    AppLocalizations? l10n,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.timer_outlined,
              size: 80,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 24),
            Text(
              l10n?.noActiveSession ?? 'No Active Session',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Text(
              l10n?.startFocusDescription ??
                  'Start a focus session from your calendar',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.outline,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () => _showQuickStartDialog(context),
              icon: const Icon(Icons.play_arrow),
              label: Text(l10n?.quickStart ?? 'Quick Start'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveSession(
    BuildContext context,
    FocusState state,
    ThemeData theme,
    AppLocalizations? l10n,
    bool isDark,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Task 정보
        Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            state.currentSession?.taskId != null
                ? 'Current Task'
                : (l10n?.focusMode ?? 'Focus Session'),
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        const SizedBox(height: 32),

        // 타이머 표시
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 250,
              height: 250,
              child: CircularProgressIndicator(
                value: state.progress,
                strokeWidth: 12,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(
                  state.isPaused
                      ? (isDark ? AppColors.warningDark : AppColors.warningLight)
                      : theme.colorScheme.primary,
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  state.formattedRemainingTime,
                  style: theme.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
                if (state.isPaused)
                  Text(
                    l10n?.paused ?? 'Paused',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? AppColors.warningDark
                          : AppColors.warningLight,
                    ),
                  ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 48),

        // 컨트롤 버튼
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 건너뛰기
            IconButton.outlined(
              onPressed: () {
                context.read<FocusBloc>().add(const SkipFocusSession());
              },
              icon: const Icon(Icons.skip_next),
              iconSize: 28,
              tooltip: l10n?.skip ?? 'Skip',
            ),
            const SizedBox(width: 24),

            // 시작/일시정지
            FilledButton(
              onPressed: () {
                if (state.isRunning) {
                  context.read<FocusBloc>().add(const PauseFocusSession());
                } else if (state.isPaused) {
                  context.read<FocusBloc>().add(const ResumeFocusSession());
                }
              },
              style: FilledButton.styleFrom(
                minimumSize: const Size(80, 80),
                shape: const CircleBorder(),
              ),
              child: Icon(
                state.isRunning ? Icons.pause : Icons.play_arrow,
                size: 40,
              ),
            ),
            const SizedBox(width: 24),

            // 완료
            IconButton.outlined(
              onPressed: () {
                context.read<FocusBloc>().add(const CompleteFocusSession());
              },
              icon: const Icon(Icons.check),
              iconSize: 28,
              tooltip: l10n?.complete ?? 'Complete',
            ),
          ],
        ),

        const Spacer(),

        // 상태 정보
        if (state.isCompleted)
          Padding(
            padding: const EdgeInsets.all(24),
            child: Card(
              color: isDark
                  ? AppColors.successDark.withValues(alpha: 0.2)
                  : AppColors.successLight.withValues(alpha: 0.2),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: isDark
                          ? AppColors.successDark
                          : AppColors.successLight,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n?.sessionCompleted ?? 'Session Completed!',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: isDark
                            ? AppColors.successDark
                            : AppColors.successLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _showQuickStartDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final focusBloc = context.read<FocusBloc>();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n?.quickStart ?? 'Quick Start'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n?.selectDuration ?? 'Select duration'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildDurationChip(dialogContext, focusBloc, 15),
                _buildDurationChip(dialogContext, focusBloc, 25),
                _buildDurationChip(dialogContext, focusBloc, 30),
                _buildDurationChip(dialogContext, focusBloc, 45),
                _buildDurationChip(dialogContext, focusBloc, 60),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n?.cancel ?? 'Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildDurationChip(BuildContext dialogContext, FocusBloc focusBloc, int minutes) {
    return ActionChip(
      label: Text('$minutes min'),
      onPressed: () {
        Navigator.of(dialogContext).pop();
        focusBloc.add(StartFocusSession(
              timeBlockId: 'quick-${DateTime.now().millisecondsSinceEpoch}',
              duration: Duration(minutes: minutes),
            ));
      },
    );
  }
}
