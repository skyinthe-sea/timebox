import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../timeblock/domain/entities/time_block.dart';
import '../bloc/focus_bloc.dart';
import '../widgets/math_challenge_dialog.dart';

/// 포커스 모드 페이지
///
/// 현재 진행 중인 타임박스에 대한 집중 화면
/// - 전체 화면 모드
/// - 뒤로가기 시 수학 문제 해제 필요
/// - 일시정지 없이 타임블록 종료시간까지 카운트다운
class FocusModePage extends StatefulWidget {
  final String? timeBlockId;
  final TimeBlock? initialTimeBlock;
  final String? taskTitle;

  const FocusModePage({
    super.key,
    this.timeBlockId,
    this.initialTimeBlock,
    this.taskTitle,
  });

  @override
  State<FocusModePage> createState() => _FocusModePageState();
}

class _FocusModePageState extends State<FocusModePage> {
  @override
  void initState() {
    super.initState();
    // 전체 화면 모드 설정
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    // 타임블록이 전달된 경우 세션 시작
    if (widget.initialTimeBlock != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<FocusBloc>().add(StartTimeBlockFocusSession(
              timeBlockId: widget.initialTimeBlock!.id,
              taskId: widget.initialTimeBlock!.taskId,
              taskTitle: widget.taskTitle ?? widget.initialTimeBlock!.title,
              endTime: widget.initialTimeBlock!.endTime,
            ));
      });
    }
  }

  @override
  void dispose() {
    // 시스템 UI 복원
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  Future<bool> _onWillPop(BuildContext context) async {
    final state = context.read<FocusBloc>().state;

    // 세션이 활성화되어 있으면 수학 문제 다이얼로그 표시
    if (state.hasActiveSession) {
      final result = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) => MathChallengeDialog(
          onSuccess: () {
            Navigator.of(dialogContext).pop(true);
          },
          onCancel: () {
            Navigator.of(dialogContext).pop(false);
          },
        ),
      );

      if (result == true && context.mounted) {
        context.read<FocusBloc>().add(const EndFocusSessionAfterChallenge());
        return true;
      }
      return false;
    }

    return true;
  }

  String _formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final shouldPop = await _onWillPop(context);
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: BlocConsumer<FocusBloc, FocusState>(
        listener: (context, state) {
          // 세션 완료 시 자동으로 뒤로가기
          if (state.isCompleted && !state.showMathChallenge) {
            Future.delayed(const Duration(seconds: 2), () {
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            });
          }
        },
        builder: (context, state) {
          // 타임블록에서 시작한 경우 Hero 태그 적용
          Widget content = Scaffold(
            backgroundColor: theme.colorScheme.surface,
            body: SafeArea(
              child: state.hasActiveSession || state.isCompleted
                  ? _buildActiveSession(context, state, theme, l10n, isDark)
                  : _buildIdleState(context, state, theme, l10n),
            ),
          );

          // Hero 애니메이션을 위한 래핑
          if (widget.initialTimeBlock != null) {
            content = Hero(
              tag: 'timeblock_${widget.initialTimeBlock!.id}',
              child: Material(
                type: MaterialType.transparency,
                child: content,
              ),
            );
          }

          return content;
        },
      ),
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
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n?.cancel ?? 'Cancel'),
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
    final taskTitle = state.taskTitle ?? l10n?.focusMode ?? 'Focus Session';
    final timeBlock = widget.initialTimeBlock;

    return LayoutBuilder(
      builder: (context, constraints) {
        // 화면 크기에 따라 타이머 크기 조절
        final timerSize = constraints.maxHeight < 500 ? 180.0 : 240.0;

        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  // 상단 앱바 영역
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            final shouldPop = await _onWillPop(context);
                            if (shouldPop && context.mounted) {
                              Navigator.of(context).pop();
                            }
                          },
                          icon: const Icon(Icons.close),
                        ),
                        const Spacer(),
                        // 집중 모드 상태 표시
                        if (!state.isCompleted)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.local_fire_department,
                                  size: 16,
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  l10n?.focusMode ?? 'Focus',
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: theme.colorScheme.onPrimaryContainer,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),

                  const Spacer(flex: 1),

                  // Task 정보
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Text(
                          taskTitle,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // 타임블록 시간 정보
                        if (timeBlock != null) ...[
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.schedule,
                                  size: 16,
                                  color: theme.colorScheme.outline,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${_formatTime(timeBlock.startTime)} - ${_formatTime(timeBlock.endTime)}',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.outline,
                                    fontFeatures: const [FontFeature.tabularFigures()],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // 타이머 표시
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: timerSize,
                        height: timerSize,
                        child: CircularProgressIndicator(
                          value: state.progress,
                          strokeWidth: 10,
                          backgroundColor: theme.colorScheme.surfaceContainerHighest,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            state.isCompleted
                                ? (isDark
                                    ? AppColors.successDark
                                    : AppColors.successLight)
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
                          if (state.isCompleted)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: isDark
                                        ? AppColors.successDark
                                        : AppColors.successLight,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    l10n?.sessionCompleted ?? 'Completed!',
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: isDark
                                          ? AppColors.successDark
                                          : AppColors.successLight,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),

                  const Spacer(flex: 2),

                  // 하단 버튼
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: state.isCompleted
                        ? FilledButton.icon(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.arrow_back),
                            label: Text(l10n?.done ?? 'Done'),
                          )
                        : TextButton.icon(
                            onPressed: () async {
                              final shouldExit = await _onWillPop(context);
                              if (shouldExit && context.mounted) {
                                context.read<FocusBloc>().add(const SkipFocusSession());
                                Navigator.of(context).pop();
                              }
                            },
                            icon: const Icon(Icons.exit_to_app),
                            label: Text(l10n?.exitFocus ?? 'Exit'),
                            style: TextButton.styleFrom(
                              foregroundColor: theme.colorScheme.error,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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

  Widget _buildDurationChip(
      BuildContext dialogContext, FocusBloc focusBloc, int minutes) {
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
