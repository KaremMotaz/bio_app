// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizModel _$QuizModelFromJson(Map<String, dynamic> json) => QuizModel(
      id: json['id'] as String,
      index: (json['index'] as num).toInt(),
      title: json['title'] as String,
      lessonId: json['lessonId'] as String,
    );

Map<String, dynamic> _$QuizModelToJson(QuizModel instance) => <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'title': instance.title,
      'lessonId': instance.lessonId,
    };
