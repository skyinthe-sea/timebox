// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_pipeline_stats_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaskPipelineStatsModel _$TaskPipelineStatsModelFromJson(
    Map<String, dynamic> json) {
  return _TaskPipelineStatsModel.fromJson(json);
}

/// @nodoc
mixin _$TaskPipelineStatsModel {
  int get totalTasks => throw _privateConstructorUsedError;
  int get scheduledTasks => throw _privateConstructorUsedError;
  int get completedTasks => throw _privateConstructorUsedError;
  int get rolledOverTasks => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskPipelineStatsModelCopyWith<TaskPipelineStatsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskPipelineStatsModelCopyWith<$Res> {
  factory $TaskPipelineStatsModelCopyWith(TaskPipelineStatsModel value,
          $Res Function(TaskPipelineStatsModel) then) =
      _$TaskPipelineStatsModelCopyWithImpl<$Res, TaskPipelineStatsModel>;
  @useResult
  $Res call(
      {int totalTasks,
      int scheduledTasks,
      int completedTasks,
      int rolledOverTasks});
}

/// @nodoc
class _$TaskPipelineStatsModelCopyWithImpl<$Res,
        $Val extends TaskPipelineStatsModel>
    implements $TaskPipelineStatsModelCopyWith<$Res> {
  _$TaskPipelineStatsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalTasks = null,
    Object? scheduledTasks = null,
    Object? completedTasks = null,
    Object? rolledOverTasks = null,
  }) {
    return _then(_value.copyWith(
      totalTasks: null == totalTasks
          ? _value.totalTasks
          : totalTasks // ignore: cast_nullable_to_non_nullable
              as int,
      scheduledTasks: null == scheduledTasks
          ? _value.scheduledTasks
          : scheduledTasks // ignore: cast_nullable_to_non_nullable
              as int,
      completedTasks: null == completedTasks
          ? _value.completedTasks
          : completedTasks // ignore: cast_nullable_to_non_nullable
              as int,
      rolledOverTasks: null == rolledOverTasks
          ? _value.rolledOverTasks
          : rolledOverTasks // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskPipelineStatsModelImplCopyWith<$Res>
    implements $TaskPipelineStatsModelCopyWith<$Res> {
  factory _$$TaskPipelineStatsModelImplCopyWith(
          _$TaskPipelineStatsModelImpl value,
          $Res Function(_$TaskPipelineStatsModelImpl) then) =
      __$$TaskPipelineStatsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalTasks,
      int scheduledTasks,
      int completedTasks,
      int rolledOverTasks});
}

/// @nodoc
class __$$TaskPipelineStatsModelImplCopyWithImpl<$Res>
    extends _$TaskPipelineStatsModelCopyWithImpl<$Res,
        _$TaskPipelineStatsModelImpl>
    implements _$$TaskPipelineStatsModelImplCopyWith<$Res> {
  __$$TaskPipelineStatsModelImplCopyWithImpl(
      _$TaskPipelineStatsModelImpl _value,
      $Res Function(_$TaskPipelineStatsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalTasks = null,
    Object? scheduledTasks = null,
    Object? completedTasks = null,
    Object? rolledOverTasks = null,
  }) {
    return _then(_$TaskPipelineStatsModelImpl(
      totalTasks: null == totalTasks
          ? _value.totalTasks
          : totalTasks // ignore: cast_nullable_to_non_nullable
              as int,
      scheduledTasks: null == scheduledTasks
          ? _value.scheduledTasks
          : scheduledTasks // ignore: cast_nullable_to_non_nullable
              as int,
      completedTasks: null == completedTasks
          ? _value.completedTasks
          : completedTasks // ignore: cast_nullable_to_non_nullable
              as int,
      rolledOverTasks: null == rolledOverTasks
          ? _value.rolledOverTasks
          : rolledOverTasks // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskPipelineStatsModelImpl extends _TaskPipelineStatsModel {
  const _$TaskPipelineStatsModelImpl(
      {required this.totalTasks,
      required this.scheduledTasks,
      required this.completedTasks,
      required this.rolledOverTasks})
      : super._();

  factory _$TaskPipelineStatsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskPipelineStatsModelImplFromJson(json);

  @override
  final int totalTasks;
  @override
  final int scheduledTasks;
  @override
  final int completedTasks;
  @override
  final int rolledOverTasks;

  @override
  String toString() {
    return 'TaskPipelineStatsModel(totalTasks: $totalTasks, scheduledTasks: $scheduledTasks, completedTasks: $completedTasks, rolledOverTasks: $rolledOverTasks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskPipelineStatsModelImpl &&
            (identical(other.totalTasks, totalTasks) ||
                other.totalTasks == totalTasks) &&
            (identical(other.scheduledTasks, scheduledTasks) ||
                other.scheduledTasks == scheduledTasks) &&
            (identical(other.completedTasks, completedTasks) ||
                other.completedTasks == completedTasks) &&
            (identical(other.rolledOverTasks, rolledOverTasks) ||
                other.rolledOverTasks == rolledOverTasks));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, totalTasks, scheduledTasks, completedTasks, rolledOverTasks);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskPipelineStatsModelImplCopyWith<_$TaskPipelineStatsModelImpl>
      get copyWith => __$$TaskPipelineStatsModelImplCopyWithImpl<
          _$TaskPipelineStatsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskPipelineStatsModelImplToJson(
      this,
    );
  }
}

abstract class _TaskPipelineStatsModel extends TaskPipelineStatsModel {
  const factory _TaskPipelineStatsModel(
      {required final int totalTasks,
      required final int scheduledTasks,
      required final int completedTasks,
      required final int rolledOverTasks}) = _$TaskPipelineStatsModelImpl;
  const _TaskPipelineStatsModel._() : super._();

  factory _TaskPipelineStatsModel.fromJson(Map<String, dynamic> json) =
      _$TaskPipelineStatsModelImpl.fromJson;

  @override
  int get totalTasks;
  @override
  int get scheduledTasks;
  @override
  int get completedTasks;
  @override
  int get rolledOverTasks;
  @override
  @JsonKey(ignore: true)
  _$$TaskPipelineStatsModelImplCopyWith<_$TaskPipelineStatsModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
