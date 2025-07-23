import 'package:bio_app/features/exam/domain/entities/question.dart';

class Exam {
  final String id;
  final String title;
  final String unit;
  final String lesson;
  final Duration duration;
  final DateTime startTime;
  final DateTime endTime;
  final int passMark;
  final List<Question> questions;
  final bool isDraft;

  Exam({
    required this.id,
    required this.title,
    required this.unit,
    required this.lesson,
    required this.duration,
    required this.startTime,
    required this.endTime,
    required this.passMark,
    required this.questions,
    required this.isDraft,
  });
}