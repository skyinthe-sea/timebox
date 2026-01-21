// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TagModelImpl _$$TagModelImplFromJson(Map<String, dynamic> json) =>
    _$TagModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      colorValue: (json['colorValue'] as num).toInt(),
      iconCodePoint: json['iconCodePoint'] as String?,
    );

Map<String, dynamic> _$$TagModelImplToJson(_$TagModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'colorValue': instance.colorValue,
      'iconCodePoint': instance.iconCodePoint,
    };
