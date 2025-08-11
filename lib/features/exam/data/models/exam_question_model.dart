import '../../domain/entities/exam_question_entity.dart';

class ExamQuestionsModel extends ExamQuestionEntity {
  ExamQuestionsModel({
    required super.index,
    required super.questionText,
    required super.options,
    required super.correctIndex,
    required super.type,
    super.marks = 1,
    super.images,
    super.title,
    super.scenario,
    super.explanation,
  });

  factory ExamQuestionsModel.fromJson(Map<String, dynamic> json) {
    return ExamQuestionsModel(
      index: json['index'] as int,
      title: json['title'] as String?,
      scenario: json['scenario'] as String?,
      questionText: json['text'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      correctIndex: json['correctIndex'] as int,
      type: ExamOptionsType.values.byName(json['type'] as String),
      marks: json['marks'],
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      explanation: json['explanation'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'title': title,
      'scenario': scenario,
      'text': questionText,
      'options': options,
      'correctIndex': correctIndex,
      'type': type,
      'marks': marks,
      'images': images,
      'explanation': explanation,
    };
  }
}

enum ExamOptionsType { textOptions, imageOptions, trueFalseOptions }
