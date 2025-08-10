import '../../../exam_questions/domain/entities/exam_question_entity.dart';

class ExamGradingService {
  static int calculateStudentScore({
    required List<ExamQuestionEntity> examQuestions,
    required Map<String, dynamic> studentAnswers,
  }) {
    int totalScore = 0;

    for (final question in examQuestions) {
      final studentAnswer = studentAnswers[question.index.toString()];
      if (studentAnswer != null &&
          studentAnswer == question.correctIndex) {
        totalScore += question.marks;
      }
    }

    return totalScore;
  }

  static int calculateMaxScore({
    required List<ExamQuestionEntity> examQuestions,
  }) {
    return examQuestions.fold(0, (sum, q) => sum + q.marks);
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

  static bool isCorrectAnswer(
    ExamQuestionEntity question,
    Map<String, int> answers,
  ) {
    final studentAnswer = answers[question.index.toString()];
    return studentAnswer != null &&
        studentAnswer == question.correctIndex;
  }
}
