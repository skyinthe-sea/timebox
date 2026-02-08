import 'package:freezed_annotation/freezed_annotation.dart';

import '../../presentation/bloc/statistics_state.dart';
import 'daily_stats_summary_model.dart';
import 'priority_breakdown_stats_model.dart';
import 'productivity_stats_model.dart';
import 'tag_time_comparison_model.dart';
import 'task_completion_ranking_model.dart';
import 'task_pipeline_stats_model.dart';
import 'time_comparison_model.dart';

part 'period_cache_model.freezed.dart';
part 'period_cache_model.g.dart';

/// PeriodCache 데이터 모델
///
/// 주간/월간 통계 캐시를 Hive에 저장하기 위한 모델
@freezed
class PeriodCacheModel with _$PeriodCacheModel {
  const PeriodCacheModel._();

  const factory PeriodCacheModel({
    /// 캐시 키 (예: period_cache_weekly_2026-W06)
    required String cacheKey,

    /// 캐시 생성 시간
    required DateTime createdAt,

    /// 기간별 생산성 통계
    required List<ProductivityStatsModel> periodStats,

    /// 태그별 시간 비교
    required List<TagTimeComparisonModel> tagStats,

    /// Task Pipeline 통계
    TaskPipelineStatsModel? pipelineStats,

    /// 우선순위별 성과 통계
    PriorityBreakdownStatsModel? priorityBreakdown,

    /// 일별 요약 목록
    required List<DailyStatsSummaryModel> periodSummaries,

    /// 시간 비교 데이터
    required List<TimeComparisonModel> timeComparisons,

    /// Top 성공 Task
    required List<TaskCompletionRankingModel> topSuccessTasks,

    /// Top 실패 Task
    required List<TaskCompletionRankingModel> topFailureTasks,
  }) = _PeriodCacheModel;

  factory PeriodCacheModel.fromJson(Map<String, dynamic> json) =>
      _$PeriodCacheModelFromJson(json);

  /// Domain PeriodCache로 변환
  PeriodCache toEntity() {
    return PeriodCache(
      periodStats: periodStats.map((m) => m.toEntity()).toList(),
      tagStats: tagStats.map((m) => m.toEntity()).toList(),
      pipelineStats: pipelineStats?.toEntity(),
      priorityBreakdown: priorityBreakdown?.toEntity(),
      periodSummaries: periodSummaries.map((m) => m.toEntity()).toList(),
      timeComparisons: timeComparisons.map((m) => m.toEntity()).toList(),
      topSuccessTasks: topSuccessTasks.map((m) => m.toEntity()).toList(),
      topFailureTasks: topFailureTasks.map((m) => m.toEntity()).toList(),
    );
  }

  /// PeriodCache + 캐시 키로 생성
  factory PeriodCacheModel.fromEntity({
    required String cacheKey,
    required PeriodCache cache,
  }) {
    return PeriodCacheModel(
      cacheKey: cacheKey,
      createdAt: DateTime.now(),
      periodStats: cache.periodStats
          .map((e) => ProductivityStatsModel.fromEntity(e))
          .toList(),
      tagStats: cache.tagStats
          .map((e) => TagTimeComparisonModel.fromEntity(e))
          .toList(),
      pipelineStats: cache.pipelineStats != null
          ? TaskPipelineStatsModel.fromEntity(cache.pipelineStats!)
          : null,
      priorityBreakdown: cache.priorityBreakdown != null
          ? PriorityBreakdownStatsModel.fromEntity(cache.priorityBreakdown!)
          : null,
      periodSummaries: cache.periodSummaries
          .map((e) => DailyStatsSummaryModel.fromEntity(e))
          .toList(),
      timeComparisons: cache.timeComparisons
          .map((e) => TimeComparisonModel.fromEntity(e))
          .toList(),
      topSuccessTasks: cache.topSuccessTasks
          .map((e) => TaskCompletionRankingModel.fromEntity(e))
          .toList(),
      topFailureTasks: cache.topFailureTasks
          .map((e) => TaskCompletionRankingModel.fromEntity(e))
          .toList(),
    );
  }

  /// 주간 캐시 키 생성 (yyyy-Www)
  static String weeklyKey(DateTime date) {
    final weekStart = date.subtract(Duration(days: date.weekday - 1));
    final weekNumber = _weekNumber(weekStart);
    return 'period_cache_weekly_${weekStart.year}-W${weekNumber.toString().padLeft(2, '0')}';
  }

  /// 월간 캐시 키 생성 (yyyy-MM)
  static String monthlyKey(DateTime date) {
    return 'period_cache_monthly_${date.year}-${date.month.toString().padLeft(2, '0')}';
  }

  /// ISO 주차 계산
  static int _weekNumber(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final firstThursday = firstDayOfYear.add(
      Duration(days: (4 - firstDayOfYear.weekday + 7) % 7),
    );
    final weekOneStart = firstThursday.subtract(const Duration(days: 3));
    final diff = date.difference(weekOneStart).inDays;
    return (diff / 7).floor() + 1;
  }
}
