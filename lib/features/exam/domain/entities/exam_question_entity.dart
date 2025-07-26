import 'package:bio_app/features/exam/data/models/question_exam_model.dart';

class ExamQuestionEntity {
  final int id;
  final String? title;
  final String? scenario;
  final String questionText;
  final ExamQuestionType type;
  final List<String>? imageUrl;
  final List<String> options;
  final String? explanation;
  final int marks;
  final int correctIndex;

  ExamQuestionEntity({
    required this.id,
    this.title,
    this.scenario,
    this.imageUrl,
    this.explanation,
    required this.questionText,
    required this.options,
    required this.correctIndex,
    required this.type,
    required this.marks,
  });
}
