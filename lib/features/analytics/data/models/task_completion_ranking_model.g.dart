// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_completion_ranking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskCompletionRankingModelImpl _$$TaskCompletionRankingModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TaskCompletionRankingModelImpl(
      title: json['title'] as String,
      totalCount: (json['totalCount'] as num).toInt(),
      completedCount: (json['completedCount'] as num).toInt(),
      completionRate: (json['completionRate'] as num).toDouble(),
    );

Map<String, dynamic> _$$TaskCompletionRankingModelImplToJson(
        _$TaskCompletionRankingModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'totalCount': instance.totalCount,
      'completedCount': instance.completedCount,
      'completionRate': instance.completionRate,
    };
