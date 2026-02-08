// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'period_cache_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PeriodCacheModel _$PeriodCacheModelFromJson(Map<String, dynamic> json) {
  return _PeriodCacheModel.fromJson(json);
}

/// @nodoc
mixin _$PeriodCacheModel {
  /// 캐시 키 (예: period_cache_weekly_2026-W06)
  String get cacheKey => throw _privateConstructorUsedError;

  /// 캐시 생성 시간
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// 기간별 생산성 통계
  List<ProductivityStatsModel> get periodStats =>
      throw _privateConstructorUsedError;

  /// 태그별 시간 비교
  List<TagTimeComparisonModel> get tagStats =>
      throw _privateConstructorUsedError;

  /// Task Pipeline 통계
  TaskPipelineStatsModel? get pipelineStats =>
      throw _privateConstructorUsedError;

  /// 우선순위별 성과 통계
  PriorityBreakdownStatsModel? get priorityBreakdown =>
      throw _privateConstructorUsedError;

  /// 일별 요약 목록
  List<DailyStatsSummaryModel> get periodSummaries =>
      throw _privateConstructorUsedError;

  /// 시간 비교 데이터
  List<TimeComparisonModel> get timeComparisons =>
      throw _privateConstructorUsedError;

  /// Top 성공 Task
  List<TaskCompletionRankingModel> get topSuccessTasks =>
      throw _privateConstructorUsedError;

  /// Top 실패 Task
  List<TaskCompletionRankingModel> get topFailureTasks =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PeriodCacheModelCopyWith<PeriodCacheModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PeriodCacheModelCopyWith<$Res> {
  factory $PeriodCacheModelCopyWith(
          PeriodCacheModel value, $Res Function(PeriodCacheModel) then) =
      _$PeriodCacheModelCopyWithImpl<$Res, PeriodCacheModel>;
  @useResult
  $Res call(
      {String cacheKey,
      DateTime createdAt,
      List<ProductivityStatsModel> periodStats,
      List<TagTimeComparisonModel> tagStats,
      TaskPipelineStatsModel? pipelineStats,
      PriorityBreakdownStatsModel? priorityBreakdown,
      List<DailyStatsSummaryModel> periodSummaries,
      List<TimeComparisonModel> timeComparisons,
      List<TaskCompletionRankingModel> topSuccessTasks,
      List<TaskCompletionRankingModel> topFailureTasks});

  $TaskPipelineStatsModelCopyWith<$Res>? get pipelineStats;
  $PriorityBreakdownStatsModelCopyWith<$Res>? get priorityBreakdown;
}

/// @nodoc
class _$PeriodCacheModelCopyWithImpl<$Res, $Val extends PeriodCacheModel>
    implements $PeriodCacheModelCopyWith<$Res> {
  _$PeriodCacheModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cacheKey = null,
    Object? createdAt = null,
    Object? periodStats = null,
    Object? tagStats = null,
    Object? pipelineStats = freezed,
    Object? priorityBreakdown = freezed,
    Object? periodSummaries = null,
    Object? timeComparisons = null,
    Object? topSuccessTasks = null,
    Object? topFailureTasks = null,
  }) {
    return _then(_value.copyWith(
      cacheKey: null == cacheKey
          ? _value.cacheKey
          : cacheKey // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      periodStats: null == periodStats
          ? _value.periodStats
          : periodStats // ignore: cast_nullable_to_non_nullable
              as List<ProductivityStatsModel>,
      tagStats: null == tagStats
          ? _value.tagStats
          : tagStats // ignore: cast_nullable_to_non_nullable
              as List<TagTimeComparisonModel>,
      pipelineStats: freezed == pipelineStats
          ? _value.pipelineStats
          : pipelineStats // ignore: cast_nullable_to_non_nullable
              as TaskPipelineStatsModel?,
      priorityBreakdown: freezed == priorityBreakdown
          ? _value.priorityBreakdown
          : priorityBreakdown // ignore: cast_nullable_to_non_nullable
              as PriorityBreakdownStatsModel?,
      periodSummaries: null == periodSummaries
          ? _value.periodSummaries
          : periodSummaries // ignore: cast_nullable_to_non_nullable
              as List<DailyStatsSummaryModel>,
      timeComparisons: null == timeComparisons
          ? _value.timeComparisons
          : timeComparisons // ignore: cast_nullable_to_non_nullable
              as List<TimeComparisonModel>,
      topSuccessTasks: null == topSuccessTasks
          ? _value.topSuccessTasks
          : topSuccessTasks // ignore: cast_nullable_to_non_nullable
              as List<TaskCompletionRankingModel>,
      topFailureTasks: null == topFailureTasks
          ? _value.topFailureTasks
          : topFailureTasks // ignore: cast_nullable_to_non_nullable
              as List<TaskCompletionRankingModel>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TaskPipelineStatsModelCopyWith<$Res>? get pipelineStats {
    if (_value.pipelineStats == null) {
      return null;
    }

    return $TaskPipelineStatsModelCopyWith<$Res>(_value.pipelineStats!,
        (value) {
      return _then(_value.copyWith(pipelineStats: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PriorityBreakdownStatsModelCopyWith<$Res>? get priorityBreakdown {
    if (_value.priorityBreakdown == null) {
      return null;
    }

    return $PriorityBreakdownStatsModelCopyWith<$Res>(_value.priorityBreakdown!,
        (value) {
      return _then(_value.copyWith(priorityBreakdown: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PeriodCacheModelImplCopyWith<$Res>
    implements $PeriodCacheModelCopyWith<$Res> {
  factory _$$PeriodCacheModelImplCopyWith(_$PeriodCacheModelImpl value,
          $Res Function(_$PeriodCacheModelImpl) then) =
      __$$PeriodCacheModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String cacheKey,
      DateTime createdAt,
      List<ProductivityStatsModel> periodStats,
      List<TagTimeComparisonModel> tagStats,
      TaskPipelineStatsModel? pipelineStats,
      PriorityBreakdownStatsModel? priorityBreakdown,
      List<DailyStatsSummaryModel> periodSummaries,
      List<TimeComparisonModel> timeComparisons,
      List<TaskCompletionRankingModel> topSuccessTasks,
      List<TaskCompletionRankingModel> topFailureTasks});

  @override
  $TaskPipelineStatsModelCopyWith<$Res>? get pipelineStats;
  @override
  $PriorityBreakdownStatsModelCopyWith<$Res>? get priorityBreakdown;
}

/// @nodoc
class __$$PeriodCacheModelImplCopyWithImpl<$Res>
    extends _$PeriodCacheModelCopyWithImpl<$Res, _$PeriodCacheModelImpl>
    implements _$$PeriodCacheModelImplCopyWith<$Res> {
  __$$PeriodCacheModelImplCopyWithImpl(_$PeriodCacheModelImpl _value,
      $Res Function(_$PeriodCacheModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cacheKey = null,
    Object? createdAt = null,
    Object? periodStats = null,
    Object? tagStats = null,
    Object? pipelineStats = freezed,
    Object? priorityBreakdown = freezed,
    Object? periodSummaries = null,
    Object? timeComparisons = null,
    Object? topSuccessTasks = null,
    Object? topFailureTasks = null,
  }) {
    return _then(_$PeriodCacheModelImpl(
      cacheKey: null == cacheKey
          ? _value.cacheKey
          : cacheKey // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      periodStats: null == periodStats
          ? _value._periodStats
          : periodStats // ignore: cast_nullable_to_non_nullable
              as List<ProductivityStatsModel>,
      tagStats: null == tagStats
          ? _value._tagStats
          : tagStats // ignore: cast_nullable_to_non_nullable
              as List<TagTimeComparisonModel>,
      pipelineStats: freezed == pipelineStats
          ? _value.pipelineStats
          : pipelineStats // ignore: cast_nullable_to_non_nullable
              as TaskPipelineStatsModel?,
      priorityBreakdown: freezed == priorityBreakdown
          ? _value.priorityBreakdown
          : priorityBreakdown // ignore: cast_nullable_to_non_nullable
              as PriorityBreakdownStatsModel?,
      periodSummaries: null == periodSummaries
          ? _value._periodSummaries
          : periodSummaries // ignore: cast_nullable_to_non_nullable
              as List<DailyStatsSummaryModel>,
      timeComparisons: null == timeComparisons
          ? _value._timeComparisons
          : timeComparisons // ignore: cast_nullable_to_non_nullable
              as List<TimeComparisonModel>,
      topSuccessTasks: null == topSuccessTasks
          ? _value._topSuccessTasks
          : topSuccessTasks // ignore: cast_nullable_to_non_nullable
              as List<TaskCompletionRankingModel>,
      topFailureTasks: null == topFailureTasks
          ? _value._topFailureTasks
          : topFailureTasks // ignore: cast_nullable_to_non_nullable
              as List<TaskCompletionRankingModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PeriodCacheModelImpl extends _PeriodCacheModel {
  const _$PeriodCacheModelImpl(
      {required this.cacheKey,
      required this.createdAt,
      required final List<ProductivityStatsModel> periodStats,
      required final List<TagTimeComparisonModel> tagStats,
      this.pipelineStats,
      this.priorityBreakdown,
      required final List<DailyStatsSummaryModel> periodSummaries,
      required final List<TimeComparisonModel> timeComparisons,
      required final List<TaskCompletionRankingModel> topSuccessTasks,
      required final List<TaskCompletionRankingModel> topFailureTasks})
      : _periodStats = periodStats,
        _tagStats = tagStats,
        _periodSummaries = periodSummaries,
        _timeComparisons = timeComparisons,
        _topSuccessTasks = topSuccessTasks,
        _topFailureTasks = topFailureTasks,
        super._();

  factory _$PeriodCacheModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PeriodCacheModelImplFromJson(json);

  /// 캐시 키 (예: period_cache_weekly_2026-W06)
  @override
  final String cacheKey;

  /// 캐시 생성 시간
  @override
  final DateTime createdAt;

  /// 기간별 생산성 통계
  final List<ProductivityStatsModel> _periodStats;

  /// 기간별 생산성 통계
  @override
  List<ProductivityStatsModel> get periodStats {
    if (_periodStats is EqualUnmodifiableListView) return _periodStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_periodStats);
  }

  /// 태그별 시간 비교
  final List<TagTimeComparisonModel> _tagStats;

  /// 태그별 시간 비교
  @override
  List<TagTimeComparisonModel> get tagStats {
    if (_tagStats is EqualUnmodifiableListView) return _tagStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tagStats);
  }

  /// Task Pipeline 통계
  @override
  final TaskPipelineStatsModel? pipelineStats;

  /// 우선순위별 성과 통계
  @override
  final PriorityBreakdownStatsModel? priorityBreakdown;

  /// 일별 요약 목록
  final List<DailyStatsSummaryModel> _periodSummaries;

  /// 일별 요약 목록
  @override
  List<DailyStatsSummaryModel> get periodSummaries {
    if (_periodSummaries is EqualUnmodifiableListView) return _periodSummaries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_periodSummaries);
  }

  /// 시간 비교 데이터
  final List<TimeComparisonModel> _timeComparisons;

  /// 시간 비교 데이터
  @override
  List<TimeComparisonModel> get timeComparisons {
    if (_timeComparisons is EqualUnmodifiableListView) return _timeComparisons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timeComparisons);
  }

  /// Top 성공 Task
  final List<TaskCompletionRankingModel> _topSuccessTasks;

  /// Top 성공 Task
  @override
  List<TaskCompletionRankingModel> get topSuccessTasks {
    if (_topSuccessTasks is EqualUnmodifiableListView) return _topSuccessTasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topSuccessTasks);
  }

  /// Top 실패 Task
  final List<TaskCompletionRankingModel> _topFailureTasks;

  /// Top 실패 Task
  @override
  List<TaskCompletionRankingModel> get topFailureTasks {
    if (_topFailureTasks is EqualUnmodifiableListView) return _topFailureTasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topFailureTasks);
  }

  @override
  String toString() {
    return 'PeriodCacheModel(cacheKey: $cacheKey, createdAt: $createdAt, periodStats: $periodStats, tagStats: $tagStats, pipelineStats: $pipelineStats, priorityBreakdown: $priorityBreakdown, periodSummaries: $periodSummaries, timeComparisons: $timeComparisons, topSuccessTasks: $topSuccessTasks, topFailureTasks: $topFailureTasks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PeriodCacheModelImpl &&
            (identical(other.cacheKey, cacheKey) ||
                other.cacheKey == cacheKey) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality()
                .equals(other._periodStats, _periodStats) &&
            const DeepCollectionEquality().equals(other._tagStats, _tagStats) &&
            (identical(other.pipelineStats, pipelineStats) ||
                other.pipelineStats == pipelineStats) &&
            (identical(other.priorityBreakdown, priorityBreakdown) ||
                other.priorityBreakdown == priorityBreakdown) &&
            const DeepCollectionEquality()
                .equals(other._periodSummaries, _periodSummaries) &&
            const DeepCollectionEquality()
                .equals(other._timeComparisons, _timeComparisons) &&
            const DeepCollectionEquality()
                .equals(other._topSuccessTasks, _topSuccessTasks) &&
            const DeepCollectionEquality()
                .equals(other._topFailureTasks, _topFailureTasks));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      cacheKey,
      createdAt,
      const DeepCollectionEquality().hash(_periodStats),
      const DeepCollectionEquality().hash(_tagStats),
      pipelineStats,
      priorityBreakdown,
      const DeepCollectionEquality().hash(_periodSummaries),
      const DeepCollectionEquality().hash(_timeComparisons),
      const DeepCollectionEquality().hash(_topSuccessTasks),
      const DeepCollectionEquality().hash(_topFailureTasks));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PeriodCacheModelImplCopyWith<_$PeriodCacheModelImpl> get copyWith =>
      __$$PeriodCacheModelImplCopyWithImpl<_$PeriodCacheModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PeriodCacheModelImplToJson(
      this,
    );
  }
}

abstract class _PeriodCacheModel extends PeriodCacheModel {
  const factory _PeriodCacheModel(
          {required final String cacheKey,
          required final DateTime createdAt,
          required final List<ProductivityStatsModel> periodStats,
          required final List<TagTimeComparisonModel> tagStats,
          final TaskPipelineStatsModel? pipelineStats,
          final PriorityBreakdownStatsModel? priorityBreakdown,
          required final List<DailyStatsSummaryModel> periodSummaries,
          required final List<TimeComparisonModel> timeComparisons,
          required final List<TaskCompletionRankingModel> topSuccessTasks,
          required final List<TaskCompletionRankingModel> topFailureTasks}) =
      _$PeriodCacheModelImpl;
  const _PeriodCacheModel._() : super._();

  factory _PeriodCacheModel.fromJson(Map<String, dynamic> json) =
      _$PeriodCacheModelImpl.fromJson;

  @override

  /// 캐시 키 (예: period_cache_weekly_2026-W06)
  String get cacheKey;
  @override

  /// 캐시 생성 시간
  DateTime get createdAt;
  @override

  /// 기간별 생산성 통계
  List<ProductivityStatsModel> get periodStats;
  @override

  /// 태그별 시간 비교
  List<TagTimeComparisonModel> get tagStats;
  @override

  /// Task Pipeline 통계
  TaskPipelineStatsModel? get pipelineStats;
  @override

  /// 우선순위별 성과 통계
  PriorityBreakdownStatsModel? get priorityBreakdown;
  @override

  /// 일별 요약 목록
  List<DailyStatsSummaryModel> get periodSummaries;
  @override

  /// 시간 비교 데이터
  List<TimeComparisonModel> get timeComparisons;
  @override

  /// Top 성공 Task
  List<TaskCompletionRankingModel> get topSuccessTasks;
  @override

  /// Top 실패 Task
  List<TaskCompletionRankingModel> get topFailureTasks;
  @override
  @JsonKey(ignore: true)
  _$$PeriodCacheModelImplCopyWith<_$PeriodCacheModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
