import '../entities/exam_entity.dart';

abstract class ExamRepo {
  Future<ExamEntity> getExamById(String id);
  Future<void> submitAnswers(
    String examId,
    Map<String, dynamic> answers,
  );
  Future<void> createExam(ExamEntity exam);
  Future<void> gradeEssay(
    String examId,
    String studentId,
    Map<String, int> essayGrades,
  );
  Future<List<ExamEntity>> getPublishedExamsForStudent(
    String studentId,
  );
}
