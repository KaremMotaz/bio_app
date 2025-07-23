import 'package:bio_app/features/exam/domain/entities/exam_result.dart';

class ExamResultModel extends ExamResultEntity {
  ExamResultModel({
    required super.examId,
    required super.studentId,
    required super.totalMarks,
    required super.obtainedMarks,
    required super.correctAnswers,
    required super.wrongAnswers,
    required super.percentage,
    required super.submittedAt,
  });

  factory ExamResultModel.fromMap(Map<String, dynamic> map) {
    return ExamResultModel(
      examId: map['examId'],
      studentId: map['studentId'],
      totalMarks: map['totalMarks'],
      obtainedMarks: map['obtainedMarks'],
      correctAnswers: map['correctAnswers'],
      wrongAnswers: map['wrongAnswers'],
      percentage: (map['percentage'] as num).toDouble(),
      submittedAt: DateTime.parse(map['submittedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'examId': examId,
      'studentId': studentId,
      'totalMarks': totalMarks,
      'obtainedMarks': obtainedMarks,
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
      'percentage': percentage,
      'submittedAt': submittedAt.toIso8601String(),
    };
  }
}
