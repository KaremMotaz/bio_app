import 'package:bio_app/features/exam/domain/entities/exam.dart';
import 'package:bio_app/features/exam/domain/entities/exam_result.dart';

abstract class ExamRepo{
  Future<Exam> getExamById(String id);
  Future<ExamResultEntity> submitAnswers(String examId, Map<String, dynamic> answers);
  Future<void> createExam(Exam exam);
  Future<void> gradeEssay(String examId, String studentId, Map<String, int> essayGrades);
  Future<List<Exam>> getPublishedExamsForStudent(String studentId);
}