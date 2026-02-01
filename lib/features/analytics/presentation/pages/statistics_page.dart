import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../l10n/app_localizations.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../domain/entities/insight.dart';
import '../../domain/entities/priority_breakdown_stats.dart';
import '../../domain/entities/task_pipeline_stats.dart';
import '../bloc/statistics_bloc.dart';
import '../bloc/statistics_event.dart';
import '../bloc/statistics_state.dart';
import '../widgets/completion_ring_row.dart';
import '../widgets/focus_summary_card.dart';
import '../widgets/plan_vs_actual_chart.dart';
import '../widgets/priority_breakdown_card.dart';
import '../widgets/productivity_score_card.dart';
import '../widgets/task_completion_ranking_card.dart';
import '../widgets/task_pipeline_funnel.dart';
import '../widgets/top_insights_section.dart';

/// 통계 페이지
///
/// 그래프/차트/애니메이션 중심 대시보드
class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  void initState() {
    super.initState();
    context.read<StatisticsBloc>().add(LoadStatistics(
          date: DateTime.now(),
          period: StatsPeriod.daily,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<StatisticsBloc, StatisticsState>(
      builder: (context, state) {
        if (state.status == StatisticsStatus.loading && !state.hasData) {
          return const Center(child: LoadingIndicator());
        }

        if (state.status == StatisticsStatus.error && !state.hasData) {
          return _buildErrorState(context, state.errorMessage);
        }

        return Column(
          children: [
            // 헤더
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.statistics,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      context
                          .read<StatisticsBloc>()
                          .add(const RefreshStatistics());
                    },
                  ),
                ],
              ),
            ),
            // 콘텐츠
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<StatisticsBloc>()
                      .add(const RefreshStatistics());
                },
                child: CustomScrollView(
                  slivers: [
                    // 1. 기간 선택 탭
                    SliverToBoxAdapter(
                      child: _buildPeriodSelector(context, state),
                    ),

                    // 2. 생산성 점수 카드 (기간에 맞는 통계 표시)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: ProductivityScoreCard(
                          score: state.displayStats?.score ?? 0,
                          scoreChange: state.scoreChange,
                          title: l10n.productivityScore,
                        ),
                      ),
                    ),

                    // 3. Completion Ring Row (3개 미니 링)
                    SliverToBoxAdapter(
                      child: CompletionRingRow(
                        taskRate:
                            state.displayStats?.taskCompletionRate ?? 0,
                        timeBlockRate:
                            state.displayStats?.timeBlockCompletionRate ?? 0,
                        timeAccuracy:
                            state.displayStats?.timeAccuracy ?? 0,
                      ),
                    ),

                    // 4. Task Pipeline Funnel
                    SliverToBoxAdapter(
                      child: TaskPipelineFunnel(
                        stats: state.pipelineStats ??
                            TaskPipelineStats.empty,
                      ),
                    ),

                    // 5. Plan vs Actual Chart
                    if (state.timeComparisons.isNotEmpty)
                      SliverToBoxAdapter(
                        child: PlanVsActualChart(
                          comparisons: state.timeComparisons,
                        ),
                      ),

                    // 6. Priority Breakdown
                    SliverToBoxAdapter(
                      child: PriorityBreakdownCard(
                        stats: state.priorityBreakdown ??
                            PriorityBreakdownStats.empty,
                      ),
                    ),

                    // 6.5. Task Completion Rankings
                    if (state.topSuccessTasks.isNotEmpty ||
                        state.topFailureTasks.isNotEmpty)
                      SliverToBoxAdapter(
                        child: TaskCompletionRankingCard(
                          topSuccess: state.topSuccessTasks,
                          topFailure: state.topFailureTasks,
                        ),
                      ),

                    // 7. Focus Summary Card
                    if (state.dailySummary != null)
                      SliverToBoxAdapter(
                        child: FocusSummaryCard(
                          summary: state.dailySummary!,
                        ),
                      ),

                    // 8. Trend Chart (주간/월간)
                    if (state.currentPeriod != StatsPeriod.daily &&
                        state.periodStats.isNotEmpty)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: _buildTrendChart(context, state),
                        ),
                      ),

                    // 9. Tag Analysis
                    if (state.tagStats.isNotEmpty)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: _buildTagChart(context, state),
                        ),
                      ),

                    // 10. Top Insights (최대 3개)
                    if (state.insights.isNotEmpty)
                      SliverToBoxAdapter(
                        child: TopInsightsSection(
                          insights: state.insights,
                          getIcon: _getInsightIcon,
                        ),
                      ),

                    // 하단 여백
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 32),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPeriodSelector(BuildContext context, StatisticsState state) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: SegmentedButton<StatsPeriod>(
        segments: [
          ButtonSegment(
            value: StatsPeriod.daily,
            label: Text(l10n.daily),
            icon: const Icon(Icons.today, size: 18),
          ),
          ButtonSegment(
            value: StatsPeriod.weekly,
            label: Text(l10n.weekly),
            icon: const Icon(Icons.date_range, size: 18),
          ),
          ButtonSegment(
            value: StatsPeriod.monthly,
            label: Text(l10n.monthly),
            icon: const Icon(Icons.calendar_month, size: 18),
          ),
        ],
        selected: {state.currentPeriod},
        onSelectionChanged: (selected) {
          context.read<StatisticsBloc>().add(ChangePeriod(selected.first));
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return theme.colorScheme.primaryContainer;
            }
            return null;
          }),
        ),
      ),
    );
  }

  Widget _buildTrendChart(BuildContext context, StatisticsState state) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Card(
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
              l10n.trend,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 25,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color:
                            theme.colorScheme.outline.withValues(alpha: 0.2),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32,
                        interval: 25,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.outline,
                            ),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 24,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= 0 &&
                              index < state.periodStats.length) {
                            final date = state.periodStats[index].date;
                            return Text(
                              '${date.day}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.outline,
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
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: (state.periodStats.length - 1).toDouble(),
                  minY: 0,
                  maxY: 100,
                  lineBarsData: [
                    LineChartBarData(
                      spots:
                          state.periodStats.asMap().entries.map((entry) {
                        return FlSpot(
                          entry.key.toDouble(),
                          entry.value.score.toDouble(),
                        );
                      }).toList(),
                      isCurved: true,
                      color: theme.colorScheme.primary,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: theme.colorScheme.primary,
                            strokeWidth: 2,
                            strokeColor: theme.colorScheme.surface,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: theme.colorScheme.primary
                            .withValues(alpha: 0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTagChart(BuildContext context, StatisticsState state) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    final colors = [
      AppColors.primaryLight,
      AppColors.secondaryLight,
      AppColors.successLight,
      AppColors.warningLight,
      AppColors.rank3,
    ];

    return Card(
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
              l10n.tagAnalysis,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: Row(
                children: [
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                        sections:
                            state.tagStats.asMap().entries.map((entry) {
                          final index = entry.key;
                          final tag = entry.value;
                          final color = colors[index % colors.length];
                          final total = state.tagStats.fold<int>(
                            0,
                            (sum, t) =>
                                sum + t.totalPlannedTime.inMinutes,
                          );
                          final percentage = total > 0
                              ? (tag.totalPlannedTime.inMinutes / total) *
                                  100
                              : 0.0;

                          return PieChartSectionData(
                            color: color,
                            value:
                                tag.totalPlannedTime.inMinutes.toDouble(),
                            title:
                                '${percentage.toStringAsFixed(0)}%',
                            radius: 50,
                            titleStyle:
                                theme.textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        state.tagStats.asMap().entries.map((entry) {
                      final index = entry.key;
                      final tag = entry.value;
                      final color = colors[index % colors.length];

                      return Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius:
                                    BorderRadius.circular(3),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              tag.tagName,
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String? message) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: theme.colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            message ?? l10n.errorGeneric,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.outline,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {
              context
                  .read<StatisticsBloc>()
                  .add(const RefreshStatistics());
            },
            icon: const Icon(Icons.refresh),
            label: Text(l10n.retry),
          ),
        ],
      ),
    );
  }

  /// InsightType에 해당하는 아이콘 반환
  IconData _getInsightIcon(InsightType type) {
    switch (type) {
      case InsightType.focusTime:
        return Icons.lightbulb_outline;
      case InsightType.tagAccuracy:
        return Icons.schedule;
      case InsightType.rolloverWarning:
        return Icons.warning_amber;
      case InsightType.streak:
        return Icons.local_fire_department;
      case InsightType.productivityChange:
        return Icons.trending_up;
      case InsightType.bestDay:
        return Icons.star;
      case InsightType.completionRate:
        return Icons.check_circle_outline;
      case InsightType.timeSaved:
        return Icons.timer;
      case InsightType.taskCompletion:
        return Icons.task_alt;
      case InsightType.focusEfficiency:
        return Icons.psychology;
      case InsightType.timeEstimation:
        return Icons.analytics_outlined;
    }
  }
}
