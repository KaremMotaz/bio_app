abstract class ExamResultRepo {
  Future<Map<String, int>> getStudentAnswers(String examId);
}
