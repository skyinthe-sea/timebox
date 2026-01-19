import 'package:flutter/material.dart';

/// 카운트다운 타이머 위젯
///
/// 원형 프로그레스와 함께 남은 시간을 표시
///
/// 기능:
/// - 남은 시간 카운트다운
/// - 원형 진행 표시기
/// - 색상 변화 (시간 임박 시)
class CountdownTimer extends StatelessWidget {
  /// 남은 시간
  final Duration remainingTime;

  /// 전체 시간 (진행률 계산용)
  final Duration totalTime;

  /// 진행률 (0.0 ~ 1.0)
  final double progress;

  /// 일시 정지 상태
  final bool isPaused;

  /// 기본 색상
  final Color? color;

  /// 크기
  final double size;

  const CountdownTimer({
    super.key,
    required this.remainingTime,
    required this.totalTime,
    required this.progress,
    this.isPaused = false,
    this.color,
    this.size = 250,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final timerColor = _getTimerColor(theme);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 배경 원
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: 12,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              color: Colors.transparent,
            ),
          ),

          // 진행 원
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: 1.0 - progress,
              strokeWidth: 12,
              backgroundColor: Colors.transparent,
              color: timerColor,
              strokeCap: StrokeCap.round,
            ),
          ),

          // 시간 텍스트
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _formatTime(remainingTime),
                style: TextStyle(
                  fontSize: size * 0.2,
                  fontWeight: FontWeight.bold,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              if (isPaused)
                Text(
                  '일시 정지', // TODO: l10n
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getTimerColor(ThemeData theme) {
    if (color != null) return color!;

    // 남은 시간에 따른 색상 변화
    if (remainingTime.inMinutes <= 1) {
      return const Color(0xFFEF4444); // Red - 임박
    } else if (remainingTime.inMinutes <= 5) {
      return const Color(0xFFF59E0B); // Amber - 주의
    }
    return theme.colorScheme.primary;
  }

  String _formatTime(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
