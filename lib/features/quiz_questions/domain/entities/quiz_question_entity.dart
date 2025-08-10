import 'package:bio_app/core/entities/base_question_entity.dart';

import '../../data/models/quiz_question_model.dart';

class QuizQuestionEntity extends BaseQuestionEntity {
  @override
  final int index;
  @override
  final String? title;
  @override
  final String? scenario;
  @override
  final String questionText;
  @override
  final List<String>? images;
  @override
  final List<String> options;
  @override
  final String? explanation;
  @override
  final int? marks;
  @override
  final int correctIndex;
  @override
  final QuizQuestionType type;

  QuizQuestionEntity({
    required this.index,
    required this.questionText,
    required this.options,
    required this.correctIndex,
    required this.type,
    required this.marks,
    this.title,
    this.scenario,
    this.images,
    this.explanation,
  });
}
