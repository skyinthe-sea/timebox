// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tag_time_comparison_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TagTimeComparisonModel _$TagTimeComparisonModelFromJson(
    Map<String, dynamic> json) {
  return _TagTimeComparisonModel.fromJson(json);
}

/// @nodoc
mixin _$TagTimeComparisonModel {
  String get tagName => throw _privateConstructorUsedError;
  int get colorValue => throw _privateConstructorUsedError;
  int get totalPlannedTimeMinutes => throw _privateConstructorUsedError;
  int get totalActualTimeMinutes => throw _privateConstructorUsedError;
  int get taskCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TagTimeComparisonModelCopyWith<TagTimeComparisonModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagTimeComparisonModelCopyWith<$Res> {
  factory $TagTimeComparisonModelCopyWith(TagTimeComparisonModel value,
          $Res Function(TagTimeComparisonModel) then) =
      _$TagTimeComparisonModelCopyWithImpl<$Res, TagTimeComparisonModel>;
  @useResult
  $Res call(
      {String tagName,
      int colorValue,
      int totalPlannedTimeMinutes,
      int totalActualTimeMinutes,
      int taskCount});
}

/// @nodoc
class _$TagTimeComparisonModelCopyWithImpl<$Res,
        $Val extends TagTimeComparisonModel>
    implements $TagTimeComparisonModelCopyWith<$Res> {
  _$TagTimeComparisonModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tagName = null,
    Object? colorValue = null,
    Object? totalPlannedTimeMinutes = null,
    Object? totalActualTimeMinutes = null,
    Object? taskCount = null,
  }) {
    return _then(_value.copyWith(
      tagName: null == tagName
          ? _value.tagName
          : tagName // ignore: cast_nullable_to_non_nullable
              as String,
      colorValue: null == colorValue
          ? _value.colorValue
          : colorValue // ignore: cast_nullable_to_non_nullable
              as int,
      totalPlannedTimeMinutes: null == totalPlannedTimeMinutes
          ? _value.totalPlannedTimeMinutes
          : totalPlannedTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      totalActualTimeMinutes: null == totalActualTimeMinutes
          ? _value.totalActualTimeMinutes
          : totalActualTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      taskCount: null == taskCount
          ? _value.taskCount
          : taskCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TagTimeComparisonModelImplCopyWith<$Res>
    implements $TagTimeComparisonModelCopyWith<$Res> {
  factory _$$TagTimeComparisonModelImplCopyWith(
          _$TagTimeComparisonModelImpl value,
          $Res Function(_$TagTimeComparisonModelImpl) then) =
      __$$TagTimeComparisonModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String tagName,
      int colorValue,
      int totalPlannedTimeMinutes,
      int totalActualTimeMinutes,
      int taskCount});
}

/// @nodoc
class __$$TagTimeComparisonModelImplCopyWithImpl<$Res>
    extends _$TagTimeComparisonModelCopyWithImpl<$Res,
        _$TagTimeComparisonModelImpl>
    implements _$$TagTimeComparisonModelImplCopyWith<$Res> {
  __$$TagTimeComparisonModelImplCopyWithImpl(
      _$TagTimeComparisonModelImpl _value,
      $Res Function(_$TagTimeComparisonModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tagName = null,
    Object? colorValue = null,
    Object? totalPlannedTimeMinutes = null,
    Object? totalActualTimeMinutes = null,
    Object? taskCount = null,
  }) {
    return _then(_$TagTimeComparisonModelImpl(
      tagName: null == tagName
          ? _value.tagName
          : tagName // ignore: cast_nullable_to_non_nullable
              as String,
      colorValue: null == colorValue
          ? _value.colorValue
          : colorValue // ignore: cast_nullable_to_non_nullable
              as int,
      totalPlannedTimeMinutes: null == totalPlannedTimeMinutes
          ? _value.totalPlannedTimeMinutes
          : totalPlannedTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      totalActualTimeMinutes: null == totalActualTimeMinutes
          ? _value.totalActualTimeMinutes
          : totalActualTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      taskCount: null == taskCount
          ? _value.taskCount
          : taskCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TagTimeComparisonModelImpl extends _TagTimeComparisonModel {
  const _$TagTimeComparisonModelImpl(
      {required this.tagName,
      required this.colorValue,
      required this.totalPlannedTimeMinutes,
      required this.totalActualTimeMinutes,
      required this.taskCount})
      : super._();

  factory _$TagTimeComparisonModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TagTimeComparisonModelImplFromJson(json);

  @override
  final String tagName;
  @override
  final int colorValue;
  @override
  final int totalPlannedTimeMinutes;
  @override
  final int totalActualTimeMinutes;
  @override
  final int taskCount;

  @override
  String toString() {
    return 'TagTimeComparisonModel(tagName: $tagName, colorValue: $colorValue, totalPlannedTimeMinutes: $totalPlannedTimeMinutes, totalActualTimeMinutes: $totalActualTimeMinutes, taskCount: $taskCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TagTimeComparisonModelImpl &&
            (identical(other.tagName, tagName) || other.tagName == tagName) &&
            (identical(other.colorValue, colorValue) ||
                other.colorValue == colorValue) &&
            (identical(
                    other.totalPlannedTimeMinutes, totalPlannedTimeMinutes) ||
                other.totalPlannedTimeMinutes == totalPlannedTimeMinutes) &&
            (identical(other.totalActualTimeMinutes, totalActualTimeMinutes) ||
                other.totalActualTimeMinutes == totalActualTimeMinutes) &&
            (identical(other.taskCount, taskCount) ||
                other.taskCount == taskCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, tagName, colorValue,
      totalPlannedTimeMinutes, totalActualTimeMinutes, taskCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TagTimeComparisonModelImplCopyWith<_$TagTimeComparisonModelImpl>
      get copyWith => __$$TagTimeComparisonModelImplCopyWithImpl<
          _$TagTimeComparisonModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TagTimeComparisonModelImplToJson(
      this,
    );
  }
}

abstract class _TagTimeComparisonModel extends TagTimeComparisonModel {
  const factory _TagTimeComparisonModel(
      {required final String tagName,
      required final int colorValue,
      required final int totalPlannedTimeMinutes,
      required final int totalActualTimeMinutes,
      required final int taskCount}) = _$TagTimeComparisonModelImpl;
  const _TagTimeComparisonModel._() : super._();

  factory _TagTimeComparisonModel.fromJson(Map<String, dynamic> json) =
      _$TagTimeComparisonModelImpl.fromJson;

  @override
  String get tagName;
  @override
  int get colorValue;
  @override
  int get totalPlannedTimeMinutes;
  @override
  int get totalActualTimeMinutes;
  @override
  int get taskCount;
  @override
  @JsonKey(ignore: true)
  _$$TagTimeComparisonModelImplCopyWith<_$TagTimeComparisonModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
