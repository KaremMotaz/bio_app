import 'exam_question_entity.dart';

class ExamEntity {
  final String id;
  final String title;
  final String unit;
  final String lesson;
  final DateTime endTime;
  final double passPercentage;
  final List<ExamQuestionEntity> questions;
  final bool isDraft;

  ExamEntity({
    required this.id,
    required this.title,
    required this.unit,
    required this.lesson,
    required this.endTime,
    required this.passPercentage,
    required this.questions,
    required this.isDraft,
  });
}
