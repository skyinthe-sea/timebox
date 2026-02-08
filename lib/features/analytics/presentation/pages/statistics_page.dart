import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../l10n/app_localizations.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../domain/entities/insight.dart';
import '../../domain/entities/priority_breakdown_stats.dart';
import '../../domain/entities/productivity_stats.dart';
import '../../domain/entities/task_pipeline_stats.dart';
import '../bloc/statistics_bloc.dart';
import '../bloc/statistics_event.dart';
import '../bloc/statistics_state.dart';
import '../widgets/completion_ring_row.dart';
import '../widgets/focus_summary_card.dart';
import '../widgets/priority_breakdown_card.dart';
import '../widgets/productivity_score_card.dart';
import '../widgets/task_completion_ranking_card.dart';
import '../widgets/task_pipeline_funnel.dart';
import '../widgets/top3_stats_card.dart';
import '../widgets/top_insights_section.dart';
import '../../../../core/widgets/stat_description_overlay.dart';

/// 통계 페이지
///
/// 그래프/차트/애니메이션 중심 대시보드
class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  late final StatisticsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<StatisticsBloc>();
    _bloc.onReportPageOpened();
    _bloc.add(LoadStatistics(
          date: DateTime.now(),
          period: StatsPeriod.daily,
        ));
  }

  @override
  void dispose() {
    _bloc.onReportPageClosed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<StatisticsBloc, StatisticsState>(
      builder: (context, state) {
        // 초기 로딩 (데이터 없음)
        if (state.status == StatisticsStatus.loading && !state.hasData) {
          return const Center(child: LoadingIndicator());
        }

        if (state.status == StatisticsStatus.error && !state.hasData) {
          return _buildErrorState(context, state.errorMessage);
        }

        // 기간 전환 시 로딩 오버레이 표시
        final showLoadingOverlay =
            state.status == StatisticsStatus.loading && state.hasData;

        return Stack(
          children: [
            Column(
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
                      child: StatDescriptionWrapper(
                        title: l10n.statDescProductivityScoreTitle,
                        description: l10n.statDescProductivityScoreBody,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: ProductivityScoreCard(
                            score: state.displayStats?.score ?? 0,
                            scoreChange: state.scoreChange,
                            title: l10n.productivityScore,
                          ),
                        ),
                      ),
                    ),

                    // 3. Completion Ring Row (3개 미니 링)
                    SliverToBoxAdapter(
                      child: StatDescriptionWrapper(
                        title: l10n.statDescCompletionRingsTitle,
                        description: l10n.statDescCompletionRingsBody,
                        child: CompletionRingRow(
                          taskRate:
                              state.displayStats?.taskCompletionRate ?? 0,
                          timeBlockRate:
                              state.displayStats?.timeBlockCompletionRate ?? 0,
                          timeAccuracy:
                              state.displayStats?.timeAccuracy ?? 0,
                        ),
                      ),
                    ),

                    // 4. Task Pipeline Funnel
                    SliverToBoxAdapter(
                      child: StatDescriptionWrapper(
                        title: l10n.statDescTaskPipelineTitle,
                        description: l10n.statDescTaskPipelineBody,
                        child: TaskPipelineFunnel(
                          stats: state.pipelineStats ??
                              TaskPipelineStats.empty,
                        ),
                      ),
                    ),

                    // 4.5. Priority Breakdown Card
                    if (state.priorityBreakdown != null &&
                        state.priorityBreakdown != PriorityBreakdownStats.empty)
                      SliverToBoxAdapter(
                        child: StatDescriptionWrapper(
                          title: l10n.statsPriorityBreakdown,
                          description: l10n.statDescPriorityBreakdownBody,
                          child: PriorityBreakdownCard(
                            stats: state.priorityBreakdown!,
                          ),
                        ),
                      ),

                    // 5. Top 3 통계 (주간/월간만)
                    if (state.currentPeriod != StatsPeriod.daily &&
                        state.periodSummaries.isNotEmpty)
                      SliverToBoxAdapter(
                        child: StatDescriptionWrapper(
                          title: l10n.statDescTop3StatsTitle,
                          description: l10n.statDescTop3StatsBody,
                          child: Top3StatsCard(
                            dailySummaries: state.periodSummaries,
                          ),
                        ),
                      ),

                    // 6.5. Task Completion Rankings
                    if (state.topSuccessTasks.isNotEmpty ||
                        state.topFailureTasks.isNotEmpty)
                      SliverToBoxAdapter(
                        child: StatDescriptionWrapper(
                          title: l10n.statDescTaskRankingTitle,
                          description: l10n.statDescTaskRankingBody,
                          child: TaskCompletionRankingCard(
                            topSuccess: state.topSuccessTasks,
                            topFailure: state.topFailureTasks,
                          ),
                        ),
                      ),

                    // 7. Focus Summary Card
                    if (state.displaySummary != null)
                      SliverToBoxAdapter(
                        child: StatDescriptionWrapper(
                          title: l10n.statDescFocusSummaryTitle,
                          description: l10n.statDescFocusSummaryBody,
                          child: FocusSummaryCard(
                            summary: state.displaySummary!,
                          ),
                        ),
                      ),

                    // 8. Trend Chart (주간/월간)
                    if (state.currentPeriod != StatsPeriod.daily &&
                        state.periodStats.isNotEmpty)
                      SliverToBoxAdapter(
                        child: StatDescriptionWrapper(
                          title: l10n.statDescTrendChartTitle,
                          description: l10n.statDescTrendChartBody,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: _buildTrendChart(context, state),
                          ),
                        ),
                      ),

                    // 9. Tag Analysis Chart
                    if (state.tagStats.isNotEmpty)
                      SliverToBoxAdapter(
                        child: StatDescriptionWrapper(
                          title: l10n.statDescTagAnalysisTitle,
                          description: l10n.statDescTagAnalysisBody,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: _buildTagChart(context, state),
                          ),
                        ),
                      ),

                    // 10. Top Insights (최대 3개)
                    if (state.insights.isNotEmpty)
                      SliverToBoxAdapter(
                        child: StatDescriptionWrapper(
                          title: l10n.statDescInsightsTitle,
                          description: l10n.statDescInsightsBody,
                          child: TopInsightsSection(
                            insights: state.insights,
                            getIcon: _getInsightIcon,
                          ),
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
            ),
            // 기간 전환 시 로딩 오버레이
            if (showLoadingOverlay)
              Positioned.fill(
                child: Container(
                  color: theme.colorScheme.surface.withValues(alpha: 0.7),
                  child: const Center(child: LoadingIndicator()),
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

    // 유효 데이터가 있는 날만 필터링 (score=0이고 tasks/blocks 모두 0인 날 제외)
    final validEntries = <int, ProductivityStats>{};
    for (var i = 0; i < state.periodStats.length; i++) {
      final s = state.periodStats[i];
      if (s.score > 0 || s.totalPlannedTasks > 0 || s.totalPlannedTimeBlocks > 0) {
        validEntries[i] = s;
      }
    }

    if (validEntries.isEmpty) {
      return const SizedBox.shrink();
    }

    final spots = validEntries.entries.map((entry) {
      return FlSpot(
        entry.key.toDouble(),
        entry.value.score.toDouble(),
      );
    }).toList();

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
                      spots: spots,
                      isCurved: true,
                      color: theme.colorScheme.primary,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          // 유효 데이터가 있는 점만 표시
                          final origIndex = spot.x.toInt();
                          final hasData = validEntries.containsKey(origIndex);
                          return FlDotCirclePainter(
                            radius: hasData ? 4 : 2,
                            color: hasData
                                ? theme.colorScheme.primary
                                : theme.colorScheme.outline.withValues(alpha: 0.3),
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

    // 태그 통계 데이터
    final tagStats = state.tagStats;
    if (tagStats.isEmpty) {
      return const SizedBox.shrink();
    }

    // 총 시간 계산 (비율 표시용)
    final totalMinutes = tagStats.fold<int>(
      0,
      (sum, tag) => sum + tag.totalPlannedTime.inMinutes,
    );

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
            Row(
              children: [
                Icon(
                  Icons.label_outline,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.tagAnalysis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 태그별 바 차트 (계획/실제 이중 바)
            ...tagStats.map((tag) {
              final percentage = totalMinutes > 0
                  ? (tag.totalPlannedTime.inMinutes / totalMinutes * 100)
                  : 0.0;
              final actualPercentage = totalMinutes > 0
                  ? (tag.totalActualTime.inMinutes / totalMinutes * 100)
                  : 0.0;
              final tagColor = Color(tag.colorValue);
              final hasActual = tag.totalActualTime.inMinutes > 0;

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: tagColor,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              tag.tagName,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          hasActual
                              ? '${_formatDuration(tag.totalPlannedTime)} → ${_formatDuration(tag.totalActualTime)}'
                              : '${tag.taskCount}${l10n.task} / ${_formatDuration(tag.totalPlannedTime)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // 이중 바: 계획(전체 바) + 실제(오버레이)
                    Stack(
                      children: [
                        // 계획 시간 바 (배경)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: percentage / 100,
                            backgroundColor:
                                theme.colorScheme.surfaceContainerHighest,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                tagColor.withValues(alpha: 0.3)),
                            minHeight: 8,
                          ),
                        ),
                        // 실제 시간 바 (오버레이)
                        if (hasActual)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: actualPercentage / 100,
                              backgroundColor: Colors.transparent,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(tagColor),
                              minHeight: 8,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
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
