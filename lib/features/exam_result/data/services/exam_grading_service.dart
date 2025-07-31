import 'package:bio_app/features/exam/domain/entities/exam_entity.dart';

class ExamGradingService {
  static int calculateStudentScore({
    required ExamEntity exam,
    required Map<String, int> studentAnswers,
  }) {
    int totalScore = 0;

    for (final question in exam.questions) {
      final studentAnswer = studentAnswers[question.id.toString()];
      if (studentAnswer != null &&
          studentAnswer == question.correctIndex) {
        totalScore += question.marks;
      }
    }

    return totalScore;
  }

  static int calculateMaxScore({required ExamEntity exam}) {
    return exam.questions.fold(0, (sum, q) => sum + q.marks);
  }

  static double calculatePercentage({
    required int studentScore,
    required int maxScore,
  }) {
    if (maxScore == 0) return 0.0;
    return (studentScore / maxScore) * 100;
  }

  static bool isPassed({
    required double studentPercentage,
    required double passPercentage,
  }) {
    return studentPercentage >= passPercentage;
  }
}
