import '../entities/exam_entity.dart';

abstract class ExamRepo {
  Future<ExamEntity> getExamById(String id);
  Future<void> submitAnswers(
    String examId,
    Map<String, dynamic> answers,
  );
}
