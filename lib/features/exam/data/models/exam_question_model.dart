import '../../domain/entities/exam_question_entity.dart';

class ExamQuestionModel extends ExamQuestionEntity {
  ExamQuestionModel({
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

  factory ExamQuestionModel.fromJson(Map<String, dynamic> json) {
    return ExamQuestionModel(
      index: json['index'],
      title: json['title'],
      scenario: json['scenario'],
      questionText: json['text'],
      options: List<String>.from(json['options']),
      correctIndex: json['correctIndex'],
      type: json['type'],
      marks: json['marks'],
      images: json['images'],
      explanation: json['explanation'],
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
