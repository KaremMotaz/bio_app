import '../../../../core/entities/base_question_entity.dart';
import '../../../../core/models/exam_question_model.dart';

class ExamQuestionEntity implements BaseQuestionEntity {
  @override
  final int id;
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
  final int marks;
  @override
  final int correctIndex;
  @override
  final ExamOptionsType type;

  ExamQuestionEntity({
    required this.id,
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
