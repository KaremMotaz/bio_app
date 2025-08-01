import '../../domain/entities/quiz_question_entity.dart';

class QuizQuestionModel extends QuizQuestionEntity {
  QuizQuestionModel({
    required super.questionText,
    required super.options,
    required super.correctIndex,
    required super.type,
    super.scenario,
    super.explanation,
    super.images,
    required super.id,
    super.marks = 1,
  });

  factory QuizQuestionModel.fromMap(Map<String, dynamic> map) {
    return QuizQuestionModel(
      questionText: map['text'],
      options: List<String>.from(map['options']),
      correctIndex: map['correctAnswerIndex'],
      type: QuizQuestionType.values.byName(map['type']),
      scenario: map['scenario'],
      explanation: map['explanation'],
      images: map['images'],
      id: map['id'],
    );
  }
}

enum QuizQuestionType { textChoices, imageChoices, trueFalse }
