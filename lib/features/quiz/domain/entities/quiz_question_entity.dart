import '../../data/models/quiz_question_model.dart';

class QuizQuestionEntity {
  final String? scenario;
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final String? explanation;
  final List<String>? images;
  final QuizQuestionType type;

  QuizQuestionEntity({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    this.scenario,
    this.explanation,
    this.images,
    required this.type,
  });
}
