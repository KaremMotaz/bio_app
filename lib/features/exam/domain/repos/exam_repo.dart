import 'package:bio_app/features/exam/domain/entities/exam_entity.dart';
import 'package:bio_app/features/exam/domain/entities/exam_result_entity.dart';

abstract class ExamRepo {
  Future<ExamEntity> getExamById(String id);
  Future<ExamResultEntity> submitAnswers(
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
