import 'package:bio_app/features/exam/domain/entities/exam_entity.dart';

class ExamGradingService {
  static int calculateStudentScore(
    ExamEntity exam,
    Map<String, int> studentAnswers,
  ) {
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

  static int calculateMaxScore(ExamEntity exam) {
    return exam.questions.fold(0, (sum, q) => sum + q.marks);
  }

  static double calculatePercentage(int studentScore, int maxScore) {
    if (maxScore == 0) return 0.0;
    return (studentScore / maxScore) * 100;
  }

  static bool isPassed(int studentScore, int passMark) {
    return studentScore >= passMark;
  }
}
