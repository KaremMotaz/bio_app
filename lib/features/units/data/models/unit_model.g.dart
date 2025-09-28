// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitModel _$UnitModelFromJson(Map<String, dynamic> json) => UnitModel(
      id: json['id'] as String,
      index: (json['index'] as num).toInt(),
      title: json['title'] as String,
      image: json['image'] as String,
      colorIndex: (json['colorIndex'] as num).toInt(),
    );

Map<String, dynamic> _$UnitModelToJson(UnitModel instance) => <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'title': instance.title,
      'image': instance.image,
      'colorIndex': instance.colorIndex,
    };
