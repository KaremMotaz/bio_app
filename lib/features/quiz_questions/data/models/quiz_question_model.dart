import '../../domain/entities/quiz_question_entity.dart';

class QuizQuestionModel extends QuizQuestionEntity {
  QuizQuestionModel({
    required super.index,
    required super.questionText,
    required super.options,
    required super.correctIndex,
    required super.type,
    super.scenario,
    super.explanation,
    super.images,
    super.title,
    super.marks,
  });

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    return QuizQuestionModel(
      index: json['index'] as int,
      questionText: json['questionText'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      correctIndex: json['correctIndex'] as int,
      type: QuizQuestionType.values.byName(json['type'] as String),
      scenario: json['scenario'] as String?,
      explanation: json['explanation'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      marks: (json['marks'] as num?)?.toInt(),
      title: json['title'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'questionText': questionText,
      'options': options,
      'correctIndex': correctIndex,
      'type': type.name,
      'scenario': scenario,
      'explanation': explanation,
      'images': images,
      'marks': marks,
      'title': title,
    };
  }
}

enum QuizQuestionType { textOptions, imageOptions, trueFalseOptions }
