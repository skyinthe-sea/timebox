import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// 타이머 컨트롤 위젯
///
/// 포커스 모드의 시작/일시정지/완료/건너뛰기 버튼
class TimerControls extends StatelessWidget {
  /// 현재 진행 중인지 여부
  final bool isRunning;

  /// 일시 정지 상태
  final bool isPaused;

  /// 시작/재개 콜백
  final VoidCallback? onStart;

  /// 일시 정지 콜백
  final VoidCallback? onPause;

  /// 완료 콜백
  final VoidCallback? onComplete;

  /// 건너뛰기 콜백
  final VoidCallback? onSkip;

  /// 시간 연장 콜백
  final VoidCallback? onExtend;

  const TimerControls({
    super.key,
    this.isRunning = false,
    this.isPaused = false,
    this.onStart,
    this.onPause,
    this.onComplete,
    this.onSkip,
    this.onExtend,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 건너뛰기 버튼
        _buildSecondaryButton(
          icon: Icons.skip_next,
          onPressed: onSkip,
          tooltip: l10n?.skip ?? 'Skip',
        ),

        const SizedBox(width: 24),

        // 메인 버튼 (시작/일시정지)
        _buildMainButton(context),

        const SizedBox(width: 24),

        // 완료 버튼
        _buildSecondaryButton(
          icon: Icons.check,
          onPressed: onComplete,
          tooltip: l10n?.complete ?? 'Complete',
        ),
      ],
    );
  }

  Widget _buildMainButton(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    // 아이콘 결정
    IconData icon;
    VoidCallback? onPressed;
    String tooltip;

    if (!isRunning || isPaused) {
      icon = Icons.play_arrow;
      onPressed = onStart;
      tooltip = isPaused
          ? (l10n?.resumeFocus ?? 'Resume')
          : (l10n?.startFocus ?? 'Start');
    } else {
      icon = Icons.pause;
      onPressed = onPause;
      tooltip = l10n?.pauseFocus ?? 'Pause';
    }

    return Tooltip(
      message: tooltip,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          minimumSize: const Size(80, 80),
          shape: const CircleBorder(),
          backgroundColor: theme.colorScheme.primary,
        ),
        child: Icon(icon, size: 40),
      ),
    );
  }

  Widget _buildSecondaryButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: IconButton.filled(
        onPressed: onPressed,
        icon: Icon(icon),
        iconSize: 28,
        style: IconButton.styleFrom(
          minimumSize: const Size(56, 56),
        ),
      ),
    );
  }
}
