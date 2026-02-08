import 'package:flutter/material.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/daily_stats_summary.dart';

/// Top 3 통계 카드
///
/// 주간/월간 기간 동안의 "가장 중요한 3가지" 달성 현황
class Top3StatsCard extends StatelessWidget {
  /// 기간 내 일별 통계 목록
  final List<DailyStatsSummary> dailySummaries;

  const Top3StatsCard({
    super.key,
    required this.dailySummaries,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    // 통계 계산
    final stats = _calculateStats();

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
              Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 20,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n.statsTop3Performance,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              if (stats.daysWithTop3 == 0)
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
                // 전체 달성률 원형 게이지
                Row(
                  children: [
                    // 원형 게이지
                    _buildCircularGauge(
                      context,
                      stats.overallRate,
                      theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 24),
                    // 상세 통계
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _StatRow(
                            icon: Icons.check_circle,
                            iconColor: AppColors.successLight,
                            label: l10n.statsTop3Completed,
                            value: '${stats.totalCompleted}/${stats.totalSlots}',
                          ),
                          const SizedBox(height: 12),
                          _StatRow(
                            icon: Icons.calendar_today,
                            iconColor: theme.colorScheme.primary,
                            label: l10n.statsTop3Days,
                            value: '${stats.daysWithTop3}${l10n.days}',
                          ),
                          const SizedBox(height: 12),
                          _StatRow(
                            icon: Icons.emoji_events,
                            iconColor: Colors.amber,
                            label: l10n.statsTop3PerfectDays,
                            value: '${stats.perfectDays}${l10n.days}',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  _Top3Stats _calculateStats() {
    if (dailySummaries.isEmpty) {
      return _Top3Stats.empty();
    }

    int totalCompleted = 0;
    int totalSlots = 0;
    int daysWithTop3 = 0;
    int perfectDays = 0;

    for (final summary in dailySummaries) {
      if (summary.top3SetCount > 0) {
        daysWithTop3++;
        totalSlots += summary.top3SetCount;
        totalCompleted += summary.top3CompletedCount;

        if (summary.top3CompletedCount >= summary.top3SetCount) {
          perfectDays++;
        }
      }
    }

    final overallRate = totalSlots > 0 ? (totalCompleted / totalSlots) * 100 : 0.0;

    return _Top3Stats(
      totalCompleted: totalCompleted,
      totalSlots: totalSlots,
      totalDays: dailySummaries.length,
      daysWithTop3: daysWithTop3,
      perfectDays: perfectDays,
      overallRate: overallRate,
    );
  }

  Widget _buildCircularGauge(BuildContext context, double percentage, Color color) {
    final theme = Theme.of(context);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: percentage / 100),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return SizedBox(
          width: 80,
          height: 80,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: value,
                strokeWidth: 8,
                backgroundColor: color.withValues(alpha: 0.15),
                valueColor: AlwaysStoppedAnimation(color),
                strokeCap: StrokeCap.round,
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${(value * 100).round()}%',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.statsAccomplished,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.outline,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StatRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _StatRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 8),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.outline,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _Top3Stats {
  final int totalCompleted;
  final int totalSlots;
  final int totalDays;
  final int daysWithTop3;
  final int perfectDays;
  final double overallRate;

  const _Top3Stats({
    required this.totalCompleted,
    required this.totalSlots,
    required this.totalDays,
    required this.daysWithTop3,
    required this.perfectDays,
    required this.overallRate,
  });

  factory _Top3Stats.empty() => const _Top3Stats(
        totalCompleted: 0,
        totalSlots: 0,
        totalDays: 0,
        daysWithTop3: 0,
        perfectDays: 0,
        overallRate: 0,
      );
}
