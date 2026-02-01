import 'package:flutter/material.dart';

import '../../../../config/themes/app_colors.dart';
import '../../domain/entities/priority_breakdown_stats.dart';
import '../../../../l10n/app_localizations.dart';

/// 우선순위별 성과 카드
///
/// 높음/보통/낮음 3줄 수평 프로그레스바
class PriorityBreakdownCard extends StatelessWidget {
  final PriorityBreakdownStats stats;

  const PriorityBreakdownCard({
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
                l10n.statsPriorityBreakdown,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              if (_isEmpty)
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
                _PriorityRow(
                  label: l10n.priorityHigh,
                  stat: stats.high,
                  color: AppColors.priorityHigh,
                  delayMs: 0,
                ),
                const SizedBox(height: 12),
                _PriorityRow(
                  label: l10n.priorityMedium,
                  stat: stats.medium,
                  color: AppColors.priorityMedium,
                  delayMs: 150,
                ),
                const SizedBox(height: 12),
                _PriorityRow(
                  label: l10n.priorityLow,
                  stat: stats.low,
                  color: AppColors.priorityLow,
                  delayMs: 300,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  bool get _isEmpty =>
      stats.high.total == 0 &&
      stats.medium.total == 0 &&
      stats.low.total == 0;
}

class _PriorityRow extends StatelessWidget {
  final String label;
  final PriorityStat stat;
  final Color color;
  final int delayMs;

  const _PriorityRow({
    required this.label,
    required this.stat,
    required this.color,
    required this.delayMs,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fraction = stat.total > 0 ? stat.completed / stat.total : 0.0;

    return Row(
      children: [
        SizedBox(
          width: 36,
          child: Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: fraction),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: value,
                  minHeight: 16,
                  backgroundColor: color.withValues(alpha: 0.15),
                  valueColor: AlwaysStoppedAnimation(color),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 72,
          child: Text(
            '${stat.completed}/${stat.total}  (${stat.completionRate.round()}%)',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.outline,
              fontSize: 11,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
