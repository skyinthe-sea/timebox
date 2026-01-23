// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_stats_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DailyStatsSummaryModel _$DailyStatsSummaryModelFromJson(
    Map<String, dynamic> json) {
  return _DailyStatsSummaryModel.fromJson(json);
}

/// @nodoc
mixin _$DailyStatsSummaryModel {
  String get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError; // Task 통계
  int get totalPlannedTasks => throw _privateConstructorUsedError;
  int get completedTasks => throw _privateConstructorUsedError;
  int get rolledOverTasks => throw _privateConstructorUsedError; // TimeBlock 통계
  int get totalTimeBlocks => throw _privateConstructorUsedError;
  int get completedTimeBlocks => throw _privateConstructorUsedError;
  int get totalPlannedDurationMinutes => throw _privateConstructorUsedError;
  int get totalActualDurationMinutes =>
      throw _privateConstructorUsedError; // Focus 통계
  int get focusSessionCount => throw _privateConstructorUsedError;
  int get totalFocusDurationMinutes => throw _privateConstructorUsedError;
  int get totalPauseDurationMinutes =>
      throw _privateConstructorUsedError; // Top 3 달성
  int get top3CompletedCount => throw _privateConstructorUsedError; // 생산성 점수
  int get productivityScore => throw _privateConstructorUsedError; // 메타데이터
  DateTime get calculatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DailyStatsSummaryModelCopyWith<DailyStatsSummaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyStatsSummaryModelCopyWith<$Res> {
  factory $DailyStatsSummaryModelCopyWith(DailyStatsSummaryModel value,
          $Res Function(DailyStatsSummaryModel) then) =
      _$DailyStatsSummaryModelCopyWithImpl<$Res, DailyStatsSummaryModel>;
  @useResult
  $Res call(
      {String id,
      DateTime date,
      int totalPlannedTasks,
      int completedTasks,
      int rolledOverTasks,
      int totalTimeBlocks,
      int completedTimeBlocks,
      int totalPlannedDurationMinutes,
      int totalActualDurationMinutes,
      int focusSessionCount,
      int totalFocusDurationMinutes,
      int totalPauseDurationMinutes,
      int top3CompletedCount,
      int productivityScore,
      DateTime calculatedAt});
}

/// @nodoc
class _$DailyStatsSummaryModelCopyWithImpl<$Res,
        $Val extends DailyStatsSummaryModel>
    implements $DailyStatsSummaryModelCopyWith<$Res> {
  _$DailyStatsSummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? totalPlannedTasks = null,
    Object? completedTasks = null,
    Object? rolledOverTasks = null,
    Object? totalTimeBlocks = null,
    Object? completedTimeBlocks = null,
    Object? totalPlannedDurationMinutes = null,
    Object? totalActualDurationMinutes = null,
    Object? focusSessionCount = null,
    Object? totalFocusDurationMinutes = null,
    Object? totalPauseDurationMinutes = null,
    Object? top3CompletedCount = null,
    Object? productivityScore = null,
    Object? calculatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalPlannedTasks: null == totalPlannedTasks
          ? _value.totalPlannedTasks
          : totalPlannedTasks // ignore: cast_nullable_to_non_nullable
              as int,
      completedTasks: null == completedTasks
          ? _value.completedTasks
          : completedTasks // ignore: cast_nullable_to_non_nullable
              as int,
      rolledOverTasks: null == rolledOverTasks
          ? _value.rolledOverTasks
          : rolledOverTasks // ignore: cast_nullable_to_non_nullable
              as int,
      totalTimeBlocks: null == totalTimeBlocks
          ? _value.totalTimeBlocks
          : totalTimeBlocks // ignore: cast_nullable_to_non_nullable
              as int,
      completedTimeBlocks: null == completedTimeBlocks
          ? _value.completedTimeBlocks
          : completedTimeBlocks // ignore: cast_nullable_to_non_nullable
              as int,
      totalPlannedDurationMinutes: null == totalPlannedDurationMinutes
          ? _value.totalPlannedDurationMinutes
          : totalPlannedDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      totalActualDurationMinutes: null == totalActualDurationMinutes
          ? _value.totalActualDurationMinutes
          : totalActualDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      focusSessionCount: null == focusSessionCount
          ? _value.focusSessionCount
          : focusSessionCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalFocusDurationMinutes: null == totalFocusDurationMinutes
          ? _value.totalFocusDurationMinutes
          : totalFocusDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      totalPauseDurationMinutes: null == totalPauseDurationMinutes
          ? _value.totalPauseDurationMinutes
          : totalPauseDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      top3CompletedCount: null == top3CompletedCount
          ? _value.top3CompletedCount
          : top3CompletedCount // ignore: cast_nullable_to_non_nullable
              as int,
      productivityScore: null == productivityScore
          ? _value.productivityScore
          : productivityScore // ignore: cast_nullable_to_non_nullable
              as int,
      calculatedAt: null == calculatedAt
          ? _value.calculatedAt
          : calculatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyStatsSummaryModelImplCopyWith<$Res>
    implements $DailyStatsSummaryModelCopyWith<$Res> {
  factory _$$DailyStatsSummaryModelImplCopyWith(
          _$DailyStatsSummaryModelImpl value,
          $Res Function(_$DailyStatsSummaryModelImpl) then) =
      __$$DailyStatsSummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime date,
      int totalPlannedTasks,
      int completedTasks,
      int rolledOverTasks,
      int totalTimeBlocks,
      int completedTimeBlocks,
      int totalPlannedDurationMinutes,
      int totalActualDurationMinutes,
      int focusSessionCount,
      int totalFocusDurationMinutes,
      int totalPauseDurationMinutes,
      int top3CompletedCount,
      int productivityScore,
      DateTime calculatedAt});
}

/// @nodoc
class __$$DailyStatsSummaryModelImplCopyWithImpl<$Res>
    extends _$DailyStatsSummaryModelCopyWithImpl<$Res,
        _$DailyStatsSummaryModelImpl>
    implements _$$DailyStatsSummaryModelImplCopyWith<$Res> {
  __$$DailyStatsSummaryModelImplCopyWithImpl(
      _$DailyStatsSummaryModelImpl _value,
      $Res Function(_$DailyStatsSummaryModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? totalPlannedTasks = null,
    Object? completedTasks = null,
    Object? rolledOverTasks = null,
    Object? totalTimeBlocks = null,
    Object? completedTimeBlocks = null,
    Object? totalPlannedDurationMinutes = null,
    Object? totalActualDurationMinutes = null,
    Object? focusSessionCount = null,
    Object? totalFocusDurationMinutes = null,
    Object? totalPauseDurationMinutes = null,
    Object? top3CompletedCount = null,
    Object? productivityScore = null,
    Object? calculatedAt = null,
  }) {
    return _then(_$DailyStatsSummaryModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalPlannedTasks: null == totalPlannedTasks
          ? _value.totalPlannedTasks
          : totalPlannedTasks // ignore: cast_nullable_to_non_nullable
              as int,
      completedTasks: null == completedTasks
          ? _value.completedTasks
          : completedTasks // ignore: cast_nullable_to_non_nullable
              as int,
      rolledOverTasks: null == rolledOverTasks
          ? _value.rolledOverTasks
          : rolledOverTasks // ignore: cast_nullable_to_non_nullable
              as int,
      totalTimeBlocks: null == totalTimeBlocks
          ? _value.totalTimeBlocks
          : totalTimeBlocks // ignore: cast_nullable_to_non_nullable
              as int,
      completedTimeBlocks: null == completedTimeBlocks
          ? _value.completedTimeBlocks
          : completedTimeBlocks // ignore: cast_nullable_to_non_nullable
              as int,
      totalPlannedDurationMinutes: null == totalPlannedDurationMinutes
          ? _value.totalPlannedDurationMinutes
          : totalPlannedDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      totalActualDurationMinutes: null == totalActualDurationMinutes
          ? _value.totalActualDurationMinutes
          : totalActualDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      focusSessionCount: null == focusSessionCount
          ? _value.focusSessionCount
          : focusSessionCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalFocusDurationMinutes: null == totalFocusDurationMinutes
          ? _value.totalFocusDurationMinutes
          : totalFocusDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      totalPauseDurationMinutes: null == totalPauseDurationMinutes
          ? _value.totalPauseDurationMinutes
          : totalPauseDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      top3CompletedCount: null == top3CompletedCount
          ? _value.top3CompletedCount
          : top3CompletedCount // ignore: cast_nullable_to_non_nullable
              as int,
      productivityScore: null == productivityScore
          ? _value.productivityScore
          : productivityScore // ignore: cast_nullable_to_non_nullable
              as int,
      calculatedAt: null == calculatedAt
          ? _value.calculatedAt
          : calculatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyStatsSummaryModelImpl extends _DailyStatsSummaryModel {
  const _$DailyStatsSummaryModelImpl(
      {required this.id,
      required this.date,
      required this.totalPlannedTasks,
      required this.completedTasks,
      this.rolledOverTasks = 0,
      required this.totalTimeBlocks,
      required this.completedTimeBlocks,
      required this.totalPlannedDurationMinutes,
      required this.totalActualDurationMinutes,
      this.focusSessionCount = 0,
      this.totalFocusDurationMinutes = 0,
      this.totalPauseDurationMinutes = 0,
      this.top3CompletedCount = 0,
      required this.productivityScore,
      required this.calculatedAt})
      : super._();

  factory _$DailyStatsSummaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyStatsSummaryModelImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime date;
// Task 통계
  @override
  final int totalPlannedTasks;
  @override
  final int completedTasks;
  @override
  @JsonKey()
  final int rolledOverTasks;
// TimeBlock 통계
  @override
  final int totalTimeBlocks;
  @override
  final int completedTimeBlocks;
  @override
  final int totalPlannedDurationMinutes;
  @override
  final int totalActualDurationMinutes;
// Focus 통계
  @override
  @JsonKey()
  final int focusSessionCount;
  @override
  @JsonKey()
  final int totalFocusDurationMinutes;
  @override
  @JsonKey()
  final int totalPauseDurationMinutes;
// Top 3 달성
  @override
  @JsonKey()
  final int top3CompletedCount;
// 생산성 점수
  @override
  final int productivityScore;
// 메타데이터
  @override
  final DateTime calculatedAt;

  @override
  String toString() {
    return 'DailyStatsSummaryModel(id: $id, date: $date, totalPlannedTasks: $totalPlannedTasks, completedTasks: $completedTasks, rolledOverTasks: $rolledOverTasks, totalTimeBlocks: $totalTimeBlocks, completedTimeBlocks: $completedTimeBlocks, totalPlannedDurationMinutes: $totalPlannedDurationMinutes, totalActualDurationMinutes: $totalActualDurationMinutes, focusSessionCount: $focusSessionCount, totalFocusDurationMinutes: $totalFocusDurationMinutes, totalPauseDurationMinutes: $totalPauseDurationMinutes, top3CompletedCount: $top3CompletedCount, productivityScore: $productivityScore, calculatedAt: $calculatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyStatsSummaryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.totalPlannedTasks, totalPlannedTasks) ||
                other.totalPlannedTasks == totalPlannedTasks) &&
            (identical(other.completedTasks, completedTasks) ||
                other.completedTasks == completedTasks) &&
            (identical(other.rolledOverTasks, rolledOverTasks) ||
                other.rolledOverTasks == rolledOverTasks) &&
            (identical(other.totalTimeBlocks, totalTimeBlocks) ||
                other.totalTimeBlocks == totalTimeBlocks) &&
            (identical(other.completedTimeBlocks, completedTimeBlocks) ||
                other.completedTimeBlocks == completedTimeBlocks) &&
            (identical(other.totalPlannedDurationMinutes,
                    totalPlannedDurationMinutes) ||
                other.totalPlannedDurationMinutes ==
                    totalPlannedDurationMinutes) &&
            (identical(other.totalActualDurationMinutes,
                    totalActualDurationMinutes) ||
                other.totalActualDurationMinutes ==
                    totalActualDurationMinutes) &&
            (identical(other.focusSessionCount, focusSessionCount) ||
                other.focusSessionCount == focusSessionCount) &&
            (identical(other.totalFocusDurationMinutes,
                    totalFocusDurationMinutes) ||
                other.totalFocusDurationMinutes == totalFocusDurationMinutes) &&
            (identical(other.totalPauseDurationMinutes,
                    totalPauseDurationMinutes) ||
                other.totalPauseDurationMinutes == totalPauseDurationMinutes) &&
            (identical(other.top3CompletedCount, top3CompletedCount) ||
                other.top3CompletedCount == top3CompletedCount) &&
            (identical(other.productivityScore, productivityScore) ||
                other.productivityScore == productivityScore) &&
            (identical(other.calculatedAt, calculatedAt) ||
                other.calculatedAt == calculatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      date,
      totalPlannedTasks,
      completedTasks,
      rolledOverTasks,
      totalTimeBlocks,
      completedTimeBlocks,
      totalPlannedDurationMinutes,
      totalActualDurationMinutes,
      focusSessionCount,
      totalFocusDurationMinutes,
      totalPauseDurationMinutes,
      top3CompletedCount,
      productivityScore,
      calculatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyStatsSummaryModelImplCopyWith<_$DailyStatsSummaryModelImpl>
      get copyWith => __$$DailyStatsSummaryModelImplCopyWithImpl<
          _$DailyStatsSummaryModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyStatsSummaryModelImplToJson(
      this,
    );
  }
}

abstract class _DailyStatsSummaryModel extends DailyStatsSummaryModel {
  const factory _DailyStatsSummaryModel(
      {required final String id,
      required final DateTime date,
      required final int totalPlannedTasks,
      required final int completedTasks,
      final int rolledOverTasks,
      required final int totalTimeBlocks,
      required final int completedTimeBlocks,
      required final int totalPlannedDurationMinutes,
      required final int totalActualDurationMinutes,
      final int focusSessionCount,
      final int totalFocusDurationMinutes,
      final int totalPauseDurationMinutes,
      final int top3CompletedCount,
      required final int productivityScore,
      required final DateTime calculatedAt}) = _$DailyStatsSummaryModelImpl;
  const _DailyStatsSummaryModel._() : super._();

  factory _DailyStatsSummaryModel.fromJson(Map<String, dynamic> json) =
      _$DailyStatsSummaryModelImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get date;
  @override // Task 통계
  int get totalPlannedTasks;
  @override
  int get completedTasks;
  @override
  int get rolledOverTasks;
  @override // TimeBlock 통계
  int get totalTimeBlocks;
  @override
  int get completedTimeBlocks;
  @override
  int get totalPlannedDurationMinutes;
  @override
  int get totalActualDurationMinutes;
  @override // Focus 통계
  int get focusSessionCount;
  @override
  int get totalFocusDurationMinutes;
  @override
  int get totalPauseDurationMinutes;
  @override // Top 3 달성
  int get top3CompletedCount;
  @override // 생산성 점수
  int get productivityScore;
  @override // 메타데이터
  DateTime get calculatedAt;
  @override
  @JsonKey(ignore: true)
  _$$DailyStatsSummaryModelImplCopyWith<_$DailyStatsSummaryModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
