// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_priority_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DailyPriorityModel _$DailyPriorityModelFromJson(Map<String, dynamic> json) {
  return _DailyPriorityModel.fromJson(json);
}

/// @nodoc
mixin _$DailyPriorityModel {
  String get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String? get rank1TaskId => throw _privateConstructorUsedError;
  String? get rank2TaskId => throw _privateConstructorUsedError;
  String? get rank3TaskId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DailyPriorityModelCopyWith<DailyPriorityModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyPriorityModelCopyWith<$Res> {
  factory $DailyPriorityModelCopyWith(
          DailyPriorityModel value, $Res Function(DailyPriorityModel) then) =
      _$DailyPriorityModelCopyWithImpl<$Res, DailyPriorityModel>;
  @useResult
  $Res call(
      {String id,
      DateTime date,
      String? rank1TaskId,
      String? rank2TaskId,
      String? rank3TaskId,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$DailyPriorityModelCopyWithImpl<$Res, $Val extends DailyPriorityModel>
    implements $DailyPriorityModelCopyWith<$Res> {
  _$DailyPriorityModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? rank1TaskId = freezed,
    Object? rank2TaskId = freezed,
    Object? rank3TaskId = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
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
      rank1TaskId: freezed == rank1TaskId
          ? _value.rank1TaskId
          : rank1TaskId // ignore: cast_nullable_to_non_nullable
              as String?,
      rank2TaskId: freezed == rank2TaskId
          ? _value.rank2TaskId
          : rank2TaskId // ignore: cast_nullable_to_non_nullable
              as String?,
      rank3TaskId: freezed == rank3TaskId
          ? _value.rank3TaskId
          : rank3TaskId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyPriorityModelImplCopyWith<$Res>
    implements $DailyPriorityModelCopyWith<$Res> {
  factory _$$DailyPriorityModelImplCopyWith(_$DailyPriorityModelImpl value,
          $Res Function(_$DailyPriorityModelImpl) then) =
      __$$DailyPriorityModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime date,
      String? rank1TaskId,
      String? rank2TaskId,
      String? rank3TaskId,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$DailyPriorityModelImplCopyWithImpl<$Res>
    extends _$DailyPriorityModelCopyWithImpl<$Res, _$DailyPriorityModelImpl>
    implements _$$DailyPriorityModelImplCopyWith<$Res> {
  __$$DailyPriorityModelImplCopyWithImpl(_$DailyPriorityModelImpl _value,
      $Res Function(_$DailyPriorityModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? rank1TaskId = freezed,
    Object? rank2TaskId = freezed,
    Object? rank3TaskId = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$DailyPriorityModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      rank1TaskId: freezed == rank1TaskId
          ? _value.rank1TaskId
          : rank1TaskId // ignore: cast_nullable_to_non_nullable
              as String?,
      rank2TaskId: freezed == rank2TaskId
          ? _value.rank2TaskId
          : rank2TaskId // ignore: cast_nullable_to_non_nullable
              as String?,
      rank3TaskId: freezed == rank3TaskId
          ? _value.rank3TaskId
          : rank3TaskId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyPriorityModelImpl extends _DailyPriorityModel {
  const _$DailyPriorityModelImpl(
      {required this.id,
      required this.date,
      this.rank1TaskId,
      this.rank2TaskId,
      this.rank3TaskId,
      required this.createdAt,
      required this.updatedAt})
      : super._();

  factory _$DailyPriorityModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyPriorityModelImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime date;
  @override
  final String? rank1TaskId;
  @override
  final String? rank2TaskId;
  @override
  final String? rank3TaskId;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'DailyPriorityModel(id: $id, date: $date, rank1TaskId: $rank1TaskId, rank2TaskId: $rank2TaskId, rank3TaskId: $rank3TaskId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyPriorityModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.rank1TaskId, rank1TaskId) ||
                other.rank1TaskId == rank1TaskId) &&
            (identical(other.rank2TaskId, rank2TaskId) ||
                other.rank2TaskId == rank2TaskId) &&
            (identical(other.rank3TaskId, rank3TaskId) ||
                other.rank3TaskId == rank3TaskId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, date, rank1TaskId,
      rank2TaskId, rank3TaskId, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyPriorityModelImplCopyWith<_$DailyPriorityModelImpl> get copyWith =>
      __$$DailyPriorityModelImplCopyWithImpl<_$DailyPriorityModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyPriorityModelImplToJson(
      this,
    );
  }
}

abstract class _DailyPriorityModel extends DailyPriorityModel {
  const factory _DailyPriorityModel(
      {required final String id,
      required final DateTime date,
      final String? rank1TaskId,
      final String? rank2TaskId,
      final String? rank3TaskId,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$DailyPriorityModelImpl;
  const _DailyPriorityModel._() : super._();

  factory _DailyPriorityModel.fromJson(Map<String, dynamic> json) =
      _$DailyPriorityModelImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get date;
  @override
  String? get rank1TaskId;
  @override
  String? get rank2TaskId;
  @override
  String? get rank3TaskId;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$DailyPriorityModelImplCopyWith<_$DailyPriorityModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
