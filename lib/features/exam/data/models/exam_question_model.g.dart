// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamQuestionsModel _$ExamQuestionsModelFromJson(Map<String, dynamic> json) =>
    ExamQuestionsModel(
      index: (json['index'] as num).toInt(),
      questionText: json['questionText'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      correctIndex: (json['correctIndex'] as num).toInt(),
      type: $enumDecode(_$ExamOptionsTypeEnumMap, json['type']),
      marks: (json['marks'] as num?)?.toInt() ?? 1,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      title: json['title'] as String?,
      scenario: json['scenario'] as String?,
      explanation: json['explanation'] as String?,
    );

Map<String, dynamic> _$ExamQuestionsModelToJson(ExamQuestionsModel instance) =>
    <String, dynamic>{
      'index': instance.index,
      'title': instance.title,
      'scenario': instance.scenario,
      'questionText': instance.questionText,
      'images': instance.images,
      'options': instance.options,
      'explanation': instance.explanation,
      'marks': instance.marks,
      'correctIndex': instance.correctIndex,
      'type': _$ExamOptionsTypeEnumMap[instance.type]!,
    };

const _$ExamOptionsTypeEnumMap = {
  ExamOptionsType.textOptions: 'textOptions',
  ExamOptionsType.imageOptions: 'imageOptions',
  ExamOptionsType.trueFalseOptions: 'trueFalseOptions',
};
