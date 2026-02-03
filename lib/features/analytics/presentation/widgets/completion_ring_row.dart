import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../l10n/app_localizations.dart';

/// 3개 미니 완료율 링 (Task율 / 실행률 / 시간정확도)
class CompletionRingRow extends StatelessWidget {
  final double taskRate;
  final double timeBlockRate;
  final double timeAccuracy;

  const CompletionRingRow({
    super.key,
    required this.taskRate,
    required this.timeBlockRate,
    required this.timeAccuracy,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: _MiniRingCard(
              label: l10n.task,
              value: taskRate,
              color: AppColors.successLight,
              darkColor: AppColors.successDark,
              delayMs: 0,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _MiniRingCard(
              label: l10n.statsScheduled,
              value: timeBlockRate,
              color: AppColors.primaryLight,
              darkColor: AppColors.primaryDark,
              delayMs: 100,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _MiniRingCard(
              label: l10n.statsEfficiency,
              value: timeAccuracy,
              color: AppColors.secondaryLight,
              darkColor: AppColors.secondaryDark,
              delayMs: 200,
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniRingCard extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  final Color darkColor;
  final int delayMs;

  const _MiniRingCard({
    required this.label,
    required this.value,
    required this.color,
    required this.darkColor,
    required this.delayMs,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final ringColor = isDark ? darkColor : color;
    final clampedValue = value.clamp(0.0, 100.0);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: clampedValue / 100),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutCubic,
              builder: (context, animValue, child) {
                return SizedBox(
                  width: 60,
                  height: 60,
                  child: CustomPaint(
                    painter: _RingPainter(
                      progress: animValue,
                      color: ringColor,
                      backgroundColor: ringColor.withValues(alpha: 0.15),
                      strokeWidth: 6,
                    ),
                    child: Center(
                      child: Text(
                        '${(animValue * 100).round()}%',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ringColor,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;

  _RingPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background ring
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    // Progress ring
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}
