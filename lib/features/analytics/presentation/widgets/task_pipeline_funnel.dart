import 'package:flutter/material.dart';

import '../../../../config/themes/app_colors.dart';
import '../../domain/entities/task_pipeline_stats.dart';
import '../../../../l10n/app_localizations.dart';

/// Task 흐름 퍼널 차트
///
/// 전체 → 스케줄 → 완료 → 이월 을 가로 막대로 시각화
class TaskPipelineFunnel extends StatelessWidget {
  final TaskPipelineStats stats;

  const TaskPipelineFunnel({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

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
                l10n.statsTaskPipeline,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              if (stats.totalTasks == 0)
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
              else ...[
                _FunnelBar(
                  label: l10n.all,
                  count: stats.totalTasks,
                  maxCount: stats.totalTasks,
                  color: theme.colorScheme.outline.withValues(alpha: 0.3),
                  delayMs: 0,
                ),
                const SizedBox(height: 10),
                _FunnelBar(
                  label: l10n.statsScheduled,
                  count: stats.scheduledTasks,
                  maxCount: stats.totalTasks,
                  color: isDark ? AppColors.primaryDark : AppColors.primaryLight,
                  delayMs: 150,
                ),
                const SizedBox(height: 10),
                _FunnelBar(
                  label: l10n.statsCompleted,
                  count: stats.completedTasks,
                  maxCount: stats.totalTasks,
                  color: isDark ? AppColors.successDark : AppColors.successLight,
                  delayMs: 300,
                ),
                const SizedBox(height: 10),
                _FunnelBar(
                  label: l10n.statsRolledOver,
                  count: stats.rolledOverTasks,
                  maxCount: stats.totalTasks,
                  color: isDark ? AppColors.warningDark : AppColors.warningLight,
                  delayMs: 450,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _FunnelBar extends StatelessWidget {
  final String label;
  final int count;
  final int maxCount;
  final Color color;
  final int delayMs;

  const _FunnelBar({
    required this.label,
    required this.count,
    required this.maxCount,
    required this.color,
    required this.delayMs,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fraction = maxCount > 0 ? count / maxCount : 0.0;

    return Row(
      children: [
        SizedBox(
          width: 56,
          child: Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: fraction),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final barWidth = constraints.maxWidth * value;
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 24,
                      width: barWidth.clamp(0.0, constraints.maxWidth),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 28,
          child: Text(
            '$count',
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
