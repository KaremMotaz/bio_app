// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterModel _$ChapterModelFromJson(Map<String, dynamic> json) => ChapterModel(
      id: json['id'] as String,
      index: (json['index'] as num).toInt(),
      title: json['title'] as String,
      image: json['image'] as String,
      colorIndex: (json['colorIndex'] as num).toInt(),
    );

Map<String, dynamic> _$ChapterModelToJson(ChapterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'title': instance.title,
      'image': instance.image,
      'colorIndex': instance.colorIndex,
    };
