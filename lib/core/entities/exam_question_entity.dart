import '../models/exam_question_model.dart';

class ExamQuestionEntity {
  final int id;
  final String? title;
  final String? scenario;
  final String questionText;
  final ExamOptionsType type;
  final List<String>? images;
  final List<String> options;
  final String? explanation;
  final int marks;
  final int correctIndex;

  ExamQuestionEntity({
    required this.id,
    this.title,
    this.scenario,
    this.images,
    this.explanation,
    required this.questionText,
    required this.options,
    required this.correctIndex,
    required this.type,
    required this.marks,
  });
}
