import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../config/themes/app_colors.dart';
import '../../domain/entities/daily_stats_summary.dart';
import '../../../../l10n/app_localizations.dart';

/// 집중 분석 카드
///
/// 왼쪽: 효율 게이지, 오른쪽: 4개 텍스트 지표
class FocusSummaryCard extends StatelessWidget {
  final DailyStatsSummary summary;

  const FocusSummaryCard({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    final primaryColor = isDark ? AppColors.primaryDark : AppColors.primaryLight;

    final efficiency = summary.focusEfficiency.clamp(0.0, 100.0);
    final totalMinutes = summary.totalFocusDuration.inMinutes;
    final sessionCount = summary.focusSessionCount;
    final avgMinutes = sessionCount > 0 ? totalMinutes ~/ sessionCount : 0;
    final pauseMinutes = summary.totalPauseDuration.inMinutes;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.statsFocusSummary,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              if (sessionCount == 0)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      l10n.statsNoData,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  ),
                )
              else
                Row(
                  children: [
                    // Efficiency gauge
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: efficiency / 100),
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOutCubic,
                      builder: (context, animValue, child) {
                        return SizedBox(
                          width: 80,
                          height: 80,
                          child: CustomPaint(
                            painter: _GaugePainter(
                              progress: animValue,
                              color: primaryColor,
                              backgroundColor:
                                  primaryColor.withValues(alpha: 0.15),
                              strokeWidth: 8,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${(animValue * 100).round()}%',
                                    style:
                                        theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    l10n.statsEfficiency,
                                    style:
                                        theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.outline,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 20),
                    // Stats column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _StatLine(
                            icon: Icons.timer_outlined,
                            label: _formatDuration(totalMinutes),
                            sublabel: l10n.focusTimeMinutes,
                          ),
                          const SizedBox(height: 8),
                          _StatLine(
                            icon: Icons.repeat,
                            label: '$sessionCount',
                            sublabel: l10n.focusMode,
                          ),
                          const SizedBox(height: 8),
                          _StatLine(
                            icon: Icons.speed,
                            label: '$avgMinutes${l10n.minutes}',
                            sublabel: l10n.average,
                          ),
                          const SizedBox(height: 8),
                          _StatLine(
                            icon: Icons.pause_circle_outline,
                            label: '$pauseMinutes${l10n.minutes}',
                            sublabel: l10n.paused,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(int minutes) {
    if (minutes >= 60) {
      final h = minutes ~/ 60;
      final m = minutes % 60;
      return m > 0 ? '${h}h ${m}m' : '${h}h';
    }
    return '${minutes}m';
  }
}

class _StatLine extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sublabel;

  const _StatLine({
    required this.icon,
    required this.label,
    required this.sublabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 16, color: theme.colorScheme.outline),
        const SizedBox(width: 8),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          sublabel,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.outline,
          ),
        ),
      ],
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;

  _GaugePainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

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
  bool shouldRepaint(_GaugePainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}
