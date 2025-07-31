import '../entities/exam_question_entity.dart';

class ExamQuestionModel extends ExamQuestionEntity {
  ExamQuestionModel({
    required super.id,
    required super.questionText,
    required super.options,
    required super.correctIndex,
    required super.type,
    required super.marks,
    super.images,
    super.title,
    super.scenario,
    super.explanation,
  });

  factory ExamQuestionModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return ExamQuestionModel(
      id: map['id'],
      title: map['title'],
      scenario: map['scenario'],
      questionText: map['text'],
      options: List<String>.from(map['options']),
      correctIndex: map['correctIndex'],
      type: map['type'],
      marks: map['marks'],
      images: map['images'],
      explanation: map['explanation'],
    );
  }
}

enum ExamOptionsType {
  textOptions,
  imageOptions,
  trueFalseOptions,
}
