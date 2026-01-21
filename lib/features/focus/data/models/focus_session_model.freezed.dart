// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'focus_session_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FocusSessionModel _$FocusSessionModelFromJson(Map<String, dynamic> json) {
  return _FocusSessionModel.fromJson(json);
}

/// @nodoc
mixin _$FocusSessionModel {
  String get id => throw _privateConstructorUsedError;
  String get timeBlockId => throw _privateConstructorUsedError;
  String? get taskId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get plannedStartTime => throw _privateConstructorUsedError;
  DateTime get plannedEndTime => throw _privateConstructorUsedError;
  DateTime? get actualStartTime => throw _privateConstructorUsedError;
  DateTime? get actualEndTime => throw _privateConstructorUsedError;
  List<PauseRecordModel> get pauseRecords => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FocusSessionModelCopyWith<FocusSessionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FocusSessionModelCopyWith<$Res> {
  factory $FocusSessionModelCopyWith(
          FocusSessionModel value, $Res Function(FocusSessionModel) then) =
      _$FocusSessionModelCopyWithImpl<$Res, FocusSessionModel>;
  @useResult
  $Res call(
      {String id,
      String timeBlockId,
      String? taskId,
      String status,
      DateTime plannedStartTime,
      DateTime plannedEndTime,
      DateTime? actualStartTime,
      DateTime? actualEndTime,
      List<PauseRecordModel> pauseRecords,
      DateTime createdAt});
}

/// @nodoc
class _$FocusSessionModelCopyWithImpl<$Res, $Val extends FocusSessionModel>
    implements $FocusSessionModelCopyWith<$Res> {
  _$FocusSessionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timeBlockId = null,
    Object? taskId = freezed,
    Object? status = null,
    Object? plannedStartTime = null,
    Object? plannedEndTime = null,
    Object? actualStartTime = freezed,
    Object? actualEndTime = freezed,
    Object? pauseRecords = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      timeBlockId: null == timeBlockId
          ? _value.timeBlockId
          : timeBlockId // ignore: cast_nullable_to_non_nullable
              as String,
      taskId: freezed == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      plannedStartTime: null == plannedStartTime
          ? _value.plannedStartTime
          : plannedStartTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      plannedEndTime: null == plannedEndTime
          ? _value.plannedEndTime
          : plannedEndTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      actualStartTime: freezed == actualStartTime
          ? _value.actualStartTime
          : actualStartTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualEndTime: freezed == actualEndTime
          ? _value.actualEndTime
          : actualEndTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pauseRecords: null == pauseRecords
          ? _value.pauseRecords
          : pauseRecords // ignore: cast_nullable_to_non_nullable
              as List<PauseRecordModel>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FocusSessionModelImplCopyWith<$Res>
    implements $FocusSessionModelCopyWith<$Res> {
  factory _$$FocusSessionModelImplCopyWith(_$FocusSessionModelImpl value,
          $Res Function(_$FocusSessionModelImpl) then) =
      __$$FocusSessionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String timeBlockId,
      String? taskId,
      String status,
      DateTime plannedStartTime,
      DateTime plannedEndTime,
      DateTime? actualStartTime,
      DateTime? actualEndTime,
      List<PauseRecordModel> pauseRecords,
      DateTime createdAt});
}

/// @nodoc
class __$$FocusSessionModelImplCopyWithImpl<$Res>
    extends _$FocusSessionModelCopyWithImpl<$Res, _$FocusSessionModelImpl>
    implements _$$FocusSessionModelImplCopyWith<$Res> {
  __$$FocusSessionModelImplCopyWithImpl(_$FocusSessionModelImpl _value,
      $Res Function(_$FocusSessionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timeBlockId = null,
    Object? taskId = freezed,
    Object? status = null,
    Object? plannedStartTime = null,
    Object? plannedEndTime = null,
    Object? actualStartTime = freezed,
    Object? actualEndTime = freezed,
    Object? pauseRecords = null,
    Object? createdAt = null,
  }) {
    return _then(_$FocusSessionModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      timeBlockId: null == timeBlockId
          ? _value.timeBlockId
          : timeBlockId // ignore: cast_nullable_to_non_nullable
              as String,
      taskId: freezed == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      plannedStartTime: null == plannedStartTime
          ? _value.plannedStartTime
          : plannedStartTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      plannedEndTime: null == plannedEndTime
          ? _value.plannedEndTime
          : plannedEndTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      actualStartTime: freezed == actualStartTime
          ? _value.actualStartTime
          : actualStartTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualEndTime: freezed == actualEndTime
          ? _value.actualEndTime
          : actualEndTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pauseRecords: null == pauseRecords
          ? _value._pauseRecords
          : pauseRecords // ignore: cast_nullable_to_non_nullable
              as List<PauseRecordModel>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FocusSessionModelImpl extends _FocusSessionModel {
  const _$FocusSessionModelImpl(
      {required this.id,
      required this.timeBlockId,
      this.taskId,
      this.status = 'pending',
      required this.plannedStartTime,
      required this.plannedEndTime,
      this.actualStartTime,
      this.actualEndTime,
      final List<PauseRecordModel> pauseRecords = const [],
      required this.createdAt})
      : _pauseRecords = pauseRecords,
        super._();

  factory _$FocusSessionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FocusSessionModelImplFromJson(json);

  @override
  final String id;
  @override
  final String timeBlockId;
  @override
  final String? taskId;
  @override
  @JsonKey()
  final String status;
  @override
  final DateTime plannedStartTime;
  @override
  final DateTime plannedEndTime;
  @override
  final DateTime? actualStartTime;
  @override
  final DateTime? actualEndTime;
  final List<PauseRecordModel> _pauseRecords;
  @override
  @JsonKey()
  List<PauseRecordModel> get pauseRecords {
    if (_pauseRecords is EqualUnmodifiableListView) return _pauseRecords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pauseRecords);
  }

  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'FocusSessionModel(id: $id, timeBlockId: $timeBlockId, taskId: $taskId, status: $status, plannedStartTime: $plannedStartTime, plannedEndTime: $plannedEndTime, actualStartTime: $actualStartTime, actualEndTime: $actualEndTime, pauseRecords: $pauseRecords, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FocusSessionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.timeBlockId, timeBlockId) ||
                other.timeBlockId == timeBlockId) &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.plannedStartTime, plannedStartTime) ||
                other.plannedStartTime == plannedStartTime) &&
            (identical(other.plannedEndTime, plannedEndTime) ||
                other.plannedEndTime == plannedEndTime) &&
            (identical(other.actualStartTime, actualStartTime) ||
                other.actualStartTime == actualStartTime) &&
            (identical(other.actualEndTime, actualEndTime) ||
                other.actualEndTime == actualEndTime) &&
            const DeepCollectionEquality()
                .equals(other._pauseRecords, _pauseRecords) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      timeBlockId,
      taskId,
      status,
      plannedStartTime,
      plannedEndTime,
      actualStartTime,
      actualEndTime,
      const DeepCollectionEquality().hash(_pauseRecords),
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FocusSessionModelImplCopyWith<_$FocusSessionModelImpl> get copyWith =>
      __$$FocusSessionModelImplCopyWithImpl<_$FocusSessionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FocusSessionModelImplToJson(
      this,
    );
  }
}

abstract class _FocusSessionModel extends FocusSessionModel {
  const factory _FocusSessionModel(
      {required final String id,
      required final String timeBlockId,
      final String? taskId,
      final String status,
      required final DateTime plannedStartTime,
      required final DateTime plannedEndTime,
      final DateTime? actualStartTime,
      final DateTime? actualEndTime,
      final List<PauseRecordModel> pauseRecords,
      required final DateTime createdAt}) = _$FocusSessionModelImpl;
  const _FocusSessionModel._() : super._();

  factory _FocusSessionModel.fromJson(Map<String, dynamic> json) =
      _$FocusSessionModelImpl.fromJson;

  @override
  String get id;
  @override
  String get timeBlockId;
  @override
  String? get taskId;
  @override
  String get status;
  @override
  DateTime get plannedStartTime;
  @override
  DateTime get plannedEndTime;
  @override
  DateTime? get actualStartTime;
  @override
  DateTime? get actualEndTime;
  @override
  List<PauseRecordModel> get pauseRecords;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$FocusSessionModelImplCopyWith<_$FocusSessionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PauseRecordModel _$PauseRecordModelFromJson(Map<String, dynamic> json) {
  return _PauseRecordModel.fromJson(json);
}

/// @nodoc
mixin _$PauseRecordModel {
  DateTime get pauseTime => throw _privateConstructorUsedError;
  DateTime? get resumeTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PauseRecordModelCopyWith<PauseRecordModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PauseRecordModelCopyWith<$Res> {
  factory $PauseRecordModelCopyWith(
          PauseRecordModel value, $Res Function(PauseRecordModel) then) =
      _$PauseRecordModelCopyWithImpl<$Res, PauseRecordModel>;
  @useResult
  $Res call({DateTime pauseTime, DateTime? resumeTime});
}

/// @nodoc
class _$PauseRecordModelCopyWithImpl<$Res, $Val extends PauseRecordModel>
    implements $PauseRecordModelCopyWith<$Res> {
  _$PauseRecordModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pauseTime = null,
    Object? resumeTime = freezed,
  }) {
    return _then(_value.copyWith(
      pauseTime: null == pauseTime
          ? _value.pauseTime
          : pauseTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      resumeTime: freezed == resumeTime
          ? _value.resumeTime
          : resumeTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PauseRecordModelImplCopyWith<$Res>
    implements $PauseRecordModelCopyWith<$Res> {
  factory _$$PauseRecordModelImplCopyWith(_$PauseRecordModelImpl value,
          $Res Function(_$PauseRecordModelImpl) then) =
      __$$PauseRecordModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime pauseTime, DateTime? resumeTime});
}

/// @nodoc
class __$$PauseRecordModelImplCopyWithImpl<$Res>
    extends _$PauseRecordModelCopyWithImpl<$Res, _$PauseRecordModelImpl>
    implements _$$PauseRecordModelImplCopyWith<$Res> {
  __$$PauseRecordModelImplCopyWithImpl(_$PauseRecordModelImpl _value,
      $Res Function(_$PauseRecordModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pauseTime = null,
    Object? resumeTime = freezed,
  }) {
    return _then(_$PauseRecordModelImpl(
      pauseTime: null == pauseTime
          ? _value.pauseTime
          : pauseTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      resumeTime: freezed == resumeTime
          ? _value.resumeTime
          : resumeTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PauseRecordModelImpl extends _PauseRecordModel {
  const _$PauseRecordModelImpl({required this.pauseTime, this.resumeTime})
      : super._();

  factory _$PauseRecordModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PauseRecordModelImplFromJson(json);

  @override
  final DateTime pauseTime;
  @override
  final DateTime? resumeTime;

  @override
  String toString() {
    return 'PauseRecordModel(pauseTime: $pauseTime, resumeTime: $resumeTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PauseRecordModelImpl &&
            (identical(other.pauseTime, pauseTime) ||
                other.pauseTime == pauseTime) &&
            (identical(other.resumeTime, resumeTime) ||
                other.resumeTime == resumeTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, pauseTime, resumeTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PauseRecordModelImplCopyWith<_$PauseRecordModelImpl> get copyWith =>
      __$$PauseRecordModelImplCopyWithImpl<_$PauseRecordModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PauseRecordModelImplToJson(
      this,
    );
  }
}

abstract class _PauseRecordModel extends PauseRecordModel {
  const factory _PauseRecordModel(
      {required final DateTime pauseTime,
      final DateTime? resumeTime}) = _$PauseRecordModelImpl;
  const _PauseRecordModel._() : super._();

  factory _PauseRecordModel.fromJson(Map<String, dynamic> json) =
      _$PauseRecordModelImpl.fromJson;

  @override
  DateTime get pauseTime;
  @override
  DateTime? get resumeTime;
  @override
  @JsonKey(ignore: true)
  _$$PauseRecordModelImplCopyWith<_$PauseRecordModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
