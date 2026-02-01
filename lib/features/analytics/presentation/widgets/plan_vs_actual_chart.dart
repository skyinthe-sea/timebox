import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../config/themes/app_colors.dart';
import '../../domain/entities/time_comparison.dart';
import '../../../../l10n/app_localizations.dart';

/// 계획 vs 실제 시간 BarChart
///
/// 각 TimeBlock당 2개 막대: 계획(연한색) vs 실제(진한색)
class PlanVsActualChart extends StatelessWidget {
  final List<TimeComparison> comparisons;

  const PlanVsActualChart({
    super.key,
    required this.comparisons,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    // actual 데이터가 있는 것만 필터, 최대 6개
    final filtered = comparisons
        .where((c) => c.actualDuration.inMinutes > 0)
        .take(6)
        .toList();

    if (filtered.isEmpty) {
      return const SizedBox.shrink();
    }

    final primaryColor = isDark ? AppColors.primaryDark : AppColors.primaryLight;
    final warningColor = isDark ? AppColors.warningDark : AppColors.warningLight;

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
                l10n.statsPlanVsActual,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              // Legend
              Row(
                children: [
                  _LegendDot(
                    color: primaryColor.withValues(alpha: 0.4),
                    label: l10n.plannedVsActual.split(' vs ').first,
                  ),
                  const SizedBox(width: 16),
                  _LegendDot(
                    color: primaryColor,
                    label: l10n.plannedVsActual.split(' vs ').last,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: _maxY(filtered),
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          final comp = filtered[groupIndex];
                          final isPlanned = rodIndex == 0;
                          final minutes = isPlanned
                              ? comp.plannedDuration.inMinutes
                              : comp.actualDuration.inMinutes;
                          return BarTooltipItem(
                            '$minutes${l10n.minutes}',
                            theme.textTheme.bodySmall!.copyWith(
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 32,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              '${value.toInt()}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.outline,
                                fontSize: 10,
                              ),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            if (index >= 0 && index < filtered.length) {
                              final title = filtered[index].title;
                              return Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  title.length > 5
                                      ? '${title.substring(0, 5)}…'
                                      : title,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.outline,
                                    fontSize: 10,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: theme.colorScheme.outline.withValues(alpha: 0.1),
                          strokeWidth: 1,
                        );
                      },
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: filtered.asMap().entries.map((entry) {
                      final index = entry.key;
                      final comp = entry.value;
                      final planned = comp.plannedDuration.inMinutes.toDouble();
                      final actual = comp.actualDuration.inMinutes.toDouble();
                      final isOver = actual > planned;

                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: planned,
                            color: primaryColor.withValues(alpha: 0.4),
                            width: 14,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4),
                            ),
                          ),
                          BarChartRodData(
                            toY: actual,
                            color: isOver ? warningColor : primaryColor,
                            width: 14,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  duration: const Duration(milliseconds: 600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _maxY(List<TimeComparison> items) {
    double max = 0;
    for (final item in items) {
      final planned = item.plannedDuration.inMinutes.toDouble();
      final actual = item.actualDuration.inMinutes.toDouble();
      if (planned > max) max = planned;
      if (actual > max) max = actual;
    }
    return (max * 1.2).ceilToDouble().clamp(10, double.infinity);
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
        ),
      ],
    );
  }
}
