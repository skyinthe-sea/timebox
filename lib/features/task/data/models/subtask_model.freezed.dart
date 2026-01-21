// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subtask_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SubtaskModel _$SubtaskModelFromJson(Map<String, dynamic> json) {
  return _SubtaskModel.fromJson(json);
}

/// @nodoc
mixin _$SubtaskModel {
  String get id => throw _privateConstructorUsedError;
  String get taskId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubtaskModelCopyWith<SubtaskModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubtaskModelCopyWith<$Res> {
  factory $SubtaskModelCopyWith(
          SubtaskModel value, $Res Function(SubtaskModel) then) =
      _$SubtaskModelCopyWithImpl<$Res, SubtaskModel>;
  @useResult
  $Res call(
      {String id, String taskId, String title, bool isCompleted, int order});
}

/// @nodoc
class _$SubtaskModelCopyWithImpl<$Res, $Val extends SubtaskModel>
    implements $SubtaskModelCopyWith<$Res> {
  _$SubtaskModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? taskId = null,
    Object? title = null,
    Object? isCompleted = null,
    Object? order = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubtaskModelImplCopyWith<$Res>
    implements $SubtaskModelCopyWith<$Res> {
  factory _$$SubtaskModelImplCopyWith(
          _$SubtaskModelImpl value, $Res Function(_$SubtaskModelImpl) then) =
      __$$SubtaskModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String taskId, String title, bool isCompleted, int order});
}

/// @nodoc
class __$$SubtaskModelImplCopyWithImpl<$Res>
    extends _$SubtaskModelCopyWithImpl<$Res, _$SubtaskModelImpl>
    implements _$$SubtaskModelImplCopyWith<$Res> {
  __$$SubtaskModelImplCopyWithImpl(
      _$SubtaskModelImpl _value, $Res Function(_$SubtaskModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? taskId = null,
    Object? title = null,
    Object? isCompleted = null,
    Object? order = null,
  }) {
    return _then(_$SubtaskModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubtaskModelImpl extends _SubtaskModel {
  const _$SubtaskModelImpl(
      {required this.id,
      required this.taskId,
      required this.title,
      this.isCompleted = false,
      this.order = 0})
      : super._();

  factory _$SubtaskModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubtaskModelImplFromJson(json);

  @override
  final String id;
  @override
  final String taskId;
  @override
  final String title;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  @JsonKey()
  final int order;

  @override
  String toString() {
    return 'SubtaskModel(id: $id, taskId: $taskId, title: $title, isCompleted: $isCompleted, order: $order)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubtaskModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, taskId, title, isCompleted, order);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SubtaskModelImplCopyWith<_$SubtaskModelImpl> get copyWith =>
      __$$SubtaskModelImplCopyWithImpl<_$SubtaskModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubtaskModelImplToJson(
      this,
    );
  }
}

abstract class _SubtaskModel extends SubtaskModel {
  const factory _SubtaskModel(
      {required final String id,
      required final String taskId,
      required final String title,
      final bool isCompleted,
      final int order}) = _$SubtaskModelImpl;
  const _SubtaskModel._() : super._();

  factory _SubtaskModel.fromJson(Map<String, dynamic> json) =
      _$SubtaskModelImpl.fromJson;

  @override
  String get id;
  @override
  String get taskId;
  @override
  String get title;
  @override
  bool get isCompleted;
  @override
  int get order;
  @override
  @JsonKey(ignore: true)
  _$$SubtaskModelImplCopyWith<_$SubtaskModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
