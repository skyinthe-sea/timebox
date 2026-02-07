// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_completion_ranking_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaskCompletionRankingModel _$TaskCompletionRankingModelFromJson(
    Map<String, dynamic> json) {
  return _TaskCompletionRankingModel.fromJson(json);
}

/// @nodoc
mixin _$TaskCompletionRankingModel {
  String get title => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  int get completedCount => throw _privateConstructorUsedError;
  double get completionRate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskCompletionRankingModelCopyWith<TaskCompletionRankingModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCompletionRankingModelCopyWith<$Res> {
  factory $TaskCompletionRankingModelCopyWith(TaskCompletionRankingModel value,
          $Res Function(TaskCompletionRankingModel) then) =
      _$TaskCompletionRankingModelCopyWithImpl<$Res,
          TaskCompletionRankingModel>;
  @useResult
  $Res call(
      {String title,
      int totalCount,
      int completedCount,
      double completionRate});
}

/// @nodoc
class _$TaskCompletionRankingModelCopyWithImpl<$Res,
        $Val extends TaskCompletionRankingModel>
    implements $TaskCompletionRankingModelCopyWith<$Res> {
  _$TaskCompletionRankingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? totalCount = null,
    Object? completedCount = null,
    Object? completionRate = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      completedCount: null == completedCount
          ? _value.completedCount
          : completedCount // ignore: cast_nullable_to_non_nullable
              as int,
      completionRate: null == completionRate
          ? _value.completionRate
          : completionRate // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskCompletionRankingModelImplCopyWith<$Res>
    implements $TaskCompletionRankingModelCopyWith<$Res> {
  factory _$$TaskCompletionRankingModelImplCopyWith(
          _$TaskCompletionRankingModelImpl value,
          $Res Function(_$TaskCompletionRankingModelImpl) then) =
      __$$TaskCompletionRankingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      int totalCount,
      int completedCount,
      double completionRate});
}

/// @nodoc
class __$$TaskCompletionRankingModelImplCopyWithImpl<$Res>
    extends _$TaskCompletionRankingModelCopyWithImpl<$Res,
        _$TaskCompletionRankingModelImpl>
    implements _$$TaskCompletionRankingModelImplCopyWith<$Res> {
  __$$TaskCompletionRankingModelImplCopyWithImpl(
      _$TaskCompletionRankingModelImpl _value,
      $Res Function(_$TaskCompletionRankingModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? totalCount = null,
    Object? completedCount = null,
    Object? completionRate = null,
  }) {
    return _then(_$TaskCompletionRankingModelImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      completedCount: null == completedCount
          ? _value.completedCount
          : completedCount // ignore: cast_nullable_to_non_nullable
              as int,
      completionRate: null == completionRate
          ? _value.completionRate
          : completionRate // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskCompletionRankingModelImpl extends _TaskCompletionRankingModel {
  const _$TaskCompletionRankingModelImpl(
      {required this.title,
      required this.totalCount,
      required this.completedCount,
      required this.completionRate})
      : super._();

  factory _$TaskCompletionRankingModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$TaskCompletionRankingModelImplFromJson(json);

  @override
  final String title;
  @override
  final int totalCount;
  @override
  final int completedCount;
  @override
  final double completionRate;

  @override
  String toString() {
    return 'TaskCompletionRankingModel(title: $title, totalCount: $totalCount, completedCount: $completedCount, completionRate: $completionRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskCompletionRankingModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.completedCount, completedCount) ||
                other.completedCount == completedCount) &&
            (identical(other.completionRate, completionRate) ||
                other.completionRate == completionRate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, title, totalCount, completedCount, completionRate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskCompletionRankingModelImplCopyWith<_$TaskCompletionRankingModelImpl>
      get copyWith => __$$TaskCompletionRankingModelImplCopyWithImpl<
          _$TaskCompletionRankingModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskCompletionRankingModelImplToJson(
      this,
    );
  }
}

abstract class _TaskCompletionRankingModel extends TaskCompletionRankingModel {
  const factory _TaskCompletionRankingModel(
      {required final String title,
      required final int totalCount,
      required final int completedCount,
      required final double completionRate}) = _$TaskCompletionRankingModelImpl;
  const _TaskCompletionRankingModel._() : super._();

  factory _TaskCompletionRankingModel.fromJson(Map<String, dynamic> json) =
      _$TaskCompletionRankingModelImpl.fromJson;

  @override
  String get title;
  @override
  int get totalCount;
  @override
  int get completedCount;
  @override
  double get completionRate;
  @override
  @JsonKey(ignore: true)
  _$$TaskCompletionRankingModelImplCopyWith<_$TaskCompletionRankingModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
