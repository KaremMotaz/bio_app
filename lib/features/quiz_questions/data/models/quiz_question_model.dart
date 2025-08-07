import '../../domain/entities/quiz_question_entity.dart';

class QuizQuestionModel extends QuizQuestionEntity {
  QuizQuestionModel({
    required super.id,
    required super.questionText,
    required super.options,
    required super.correctIndex,
    required super.type,
    super.scenario,
    super.explanation,
    super.images,
    super.marks = 1,
  });

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    return QuizQuestionModel(
      questionText: json['text'],
      options: List<String>.from(json['options']),
      correctIndex: json['correctAnswerIndex'],
      type: QuizQuestionType.values.byName(json['type']),
      scenario: json['scenario'],
      explanation: json['explanation'],
      images: json['images'],
      id: json['id'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': questionText,
      'options': options,
      'correctAnswerIndex': correctIndex,
      'type': type.name,
      'scenario': scenario,
      'explanation': explanation,
      'images': images,
      'marks': marks,
    };
  }
}

enum QuizQuestionType { textChoices, imageChoices, trueFalse }
