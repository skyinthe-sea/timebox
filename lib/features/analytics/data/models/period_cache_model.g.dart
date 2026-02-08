// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'period_cache_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PeriodCacheModelImpl _$$PeriodCacheModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PeriodCacheModelImpl(
      cacheKey: json['cacheKey'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      periodStats: (json['periodStats'] as List<dynamic>)
          .map(
              (e) => ProductivityStatsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      tagStats: (json['tagStats'] as List<dynamic>)
          .map(
              (e) => TagTimeComparisonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pipelineStats: json['pipelineStats'] == null
          ? null
          : TaskPipelineStatsModel.fromJson(
              json['pipelineStats'] as Map<String, dynamic>),
      priorityBreakdown: json['priorityBreakdown'] == null
          ? null
          : PriorityBreakdownStatsModel.fromJson(
              json['priorityBreakdown'] as Map<String, dynamic>),
      periodSummaries: (json['periodSummaries'] as List<dynamic>)
          .map(
              (e) => DailyStatsSummaryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      timeComparisons: (json['timeComparisons'] as List<dynamic>)
          .map((e) => TimeComparisonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      topSuccessTasks: (json['topSuccessTasks'] as List<dynamic>)
          .map((e) =>
              TaskCompletionRankingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      topFailureTasks: (json['topFailureTasks'] as List<dynamic>)
          .map((e) =>
              TaskCompletionRankingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PeriodCacheModelImplToJson(
        _$PeriodCacheModelImpl instance) =>
    <String, dynamic>{
      'cacheKey': instance.cacheKey,
      'createdAt': instance.createdAt.toIso8601String(),
      'periodStats': instance.periodStats.map((e) => e.toJson()).toList(),
      'tagStats': instance.tagStats.map((e) => e.toJson()).toList(),
      'pipelineStats': instance.pipelineStats?.toJson(),
      'priorityBreakdown': instance.priorityBreakdown?.toJson(),
      'periodSummaries':
          instance.periodSummaries.map((e) => e.toJson()).toList(),
      'timeComparisons':
          instance.timeComparisons.map((e) => e.toJson()).toList(),
      'topSuccessTasks':
          instance.topSuccessTasks.map((e) => e.toJson()).toList(),
      'topFailureTasks':
          instance.topFailureTasks.map((e) => e.toJson()).toList(),
    };
