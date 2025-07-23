class ExamResultEntity {
  final String examId;
  final String studentId;
  final int totalMarks;
  final int obtainedMarks;
  final int correctAnswers;
  final int wrongAnswers;
  final double percentage;
  final DateTime submittedAt;

  ExamResultEntity({
    required this.examId,
    required this.studentId,
    required this.totalMarks,
    required this.obtainedMarks,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.percentage,
    required this.submittedAt,
  });
}
