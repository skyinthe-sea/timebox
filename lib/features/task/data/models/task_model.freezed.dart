// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) {
  return _TaskModel.fromJson(json);
}

/// @nodoc
mixin _$TaskModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  int get estimatedDurationMinutes => throw _privateConstructorUsedError;
  List<TagModel> get tags => throw _privateConstructorUsedError;
  String get priority => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  List<SubtaskModel> get subtasks => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  DateTime? get targetDate =>
      throw _privateConstructorUsedError; // nullable for backward compatibility
  int get rolloverCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskModelCopyWith<TaskModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskModelCopyWith<$Res> {
  factory $TaskModelCopyWith(TaskModel value, $Res Function(TaskModel) then) =
      _$TaskModelCopyWithImpl<$Res, TaskModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? note,
      int estimatedDurationMinutes,
      List<TagModel> tags,
      String priority,
      String status,
      List<SubtaskModel> subtasks,
      DateTime createdAt,
      DateTime? completedAt,
      DateTime? targetDate,
      int rolloverCount});
}

/// @nodoc
class _$TaskModelCopyWithImpl<$Res, $Val extends TaskModel>
    implements $TaskModelCopyWith<$Res> {
  _$TaskModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? note = freezed,
    Object? estimatedDurationMinutes = null,
    Object? tags = null,
    Object? priority = null,
    Object? status = null,
    Object? subtasks = null,
    Object? createdAt = null,
    Object? completedAt = freezed,
    Object? targetDate = freezed,
    Object? rolloverCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      estimatedDurationMinutes: null == estimatedDurationMinutes
          ? _value.estimatedDurationMinutes
          : estimatedDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagModel>,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      subtasks: null == subtasks
          ? _value.subtasks
          : subtasks // ignore: cast_nullable_to_non_nullable
              as List<SubtaskModel>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      targetDate: freezed == targetDate
          ? _value.targetDate
          : targetDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rolloverCount: null == rolloverCount
          ? _value.rolloverCount
          : rolloverCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskModelImplCopyWith<$Res>
    implements $TaskModelCopyWith<$Res> {
  factory _$$TaskModelImplCopyWith(
          _$TaskModelImpl value, $Res Function(_$TaskModelImpl) then) =
      __$$TaskModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? note,
      int estimatedDurationMinutes,
      List<TagModel> tags,
      String priority,
      String status,
      List<SubtaskModel> subtasks,
      DateTime createdAt,
      DateTime? completedAt,
      DateTime? targetDate,
      int rolloverCount});
}

/// @nodoc
class __$$TaskModelImplCopyWithImpl<$Res>
    extends _$TaskModelCopyWithImpl<$Res, _$TaskModelImpl>
    implements _$$TaskModelImplCopyWith<$Res> {
  __$$TaskModelImplCopyWithImpl(
      _$TaskModelImpl _value, $Res Function(_$TaskModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? note = freezed,
    Object? estimatedDurationMinutes = null,
    Object? tags = null,
    Object? priority = null,
    Object? status = null,
    Object? subtasks = null,
    Object? createdAt = null,
    Object? completedAt = freezed,
    Object? targetDate = freezed,
    Object? rolloverCount = null,
  }) {
    return _then(_$TaskModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      estimatedDurationMinutes: null == estimatedDurationMinutes
          ? _value.estimatedDurationMinutes
          : estimatedDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagModel>,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      subtasks: null == subtasks
          ? _value._subtasks
          : subtasks // ignore: cast_nullable_to_non_nullable
              as List<SubtaskModel>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      targetDate: freezed == targetDate
          ? _value.targetDate
          : targetDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rolloverCount: null == rolloverCount
          ? _value.rolloverCount
          : rolloverCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskModelImpl extends _TaskModel {
  const _$TaskModelImpl(
      {required this.id,
      required this.title,
      this.note,
      required this.estimatedDurationMinutes,
      final List<TagModel> tags = const [],
      this.priority = 'medium',
      this.status = 'todo',
      final List<SubtaskModel> subtasks = const [],
      required this.createdAt,
      this.completedAt,
      this.targetDate,
      this.rolloverCount = 0})
      : _tags = tags,
        _subtasks = subtasks,
        super._();

  factory _$TaskModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? note;
  @override
  final int estimatedDurationMinutes;
  final List<TagModel> _tags;
  @override
  @JsonKey()
  List<TagModel> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey()
  final String priority;
  @override
  @JsonKey()
  final String status;
  final List<SubtaskModel> _subtasks;
  @override
  @JsonKey()
  List<SubtaskModel> get subtasks {
    if (_subtasks is EqualUnmodifiableListView) return _subtasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subtasks);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime? completedAt;
  @override
  final DateTime? targetDate;
// nullable for backward compatibility
  @override
  @JsonKey()
  final int rolloverCount;

  @override
  String toString() {
    return 'TaskModel(id: $id, title: $title, note: $note, estimatedDurationMinutes: $estimatedDurationMinutes, tags: $tags, priority: $priority, status: $status, subtasks: $subtasks, createdAt: $createdAt, completedAt: $completedAt, targetDate: $targetDate, rolloverCount: $rolloverCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(
                    other.estimatedDurationMinutes, estimatedDurationMinutes) ||
                other.estimatedDurationMinutes == estimatedDurationMinutes) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._subtasks, _subtasks) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.targetDate, targetDate) ||
                other.targetDate == targetDate) &&
            (identical(other.rolloverCount, rolloverCount) ||
                other.rolloverCount == rolloverCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      note,
      estimatedDurationMinutes,
      const DeepCollectionEquality().hash(_tags),
      priority,
      status,
      const DeepCollectionEquality().hash(_subtasks),
      createdAt,
      completedAt,
      targetDate,
      rolloverCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskModelImplCopyWith<_$TaskModelImpl> get copyWith =>
      __$$TaskModelImplCopyWithImpl<_$TaskModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskModelImplToJson(
      this,
    );
  }
}

abstract class _TaskModel extends TaskModel {
  const factory _TaskModel(
      {required final String id,
      required final String title,
      final String? note,
      required final int estimatedDurationMinutes,
      final List<TagModel> tags,
      final String priority,
      final String status,
      final List<SubtaskModel> subtasks,
      required final DateTime createdAt,
      final DateTime? completedAt,
      final DateTime? targetDate,
      final int rolloverCount}) = _$TaskModelImpl;
  const _TaskModel._() : super._();

  factory _TaskModel.fromJson(Map<String, dynamic> json) =
      _$TaskModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get note;
  @override
  int get estimatedDurationMinutes;
  @override
  List<TagModel> get tags;
  @override
  String get priority;
  @override
  String get status;
  @override
  List<SubtaskModel> get subtasks;
  @override
  DateTime get createdAt;
  @override
  DateTime? get completedAt;
  @override
  DateTime? get targetDate;
  @override // nullable for backward compatibility
  int get rolloverCount;
  @override
  @JsonKey(ignore: true)
  _$$TaskModelImplCopyWith<_$TaskModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
