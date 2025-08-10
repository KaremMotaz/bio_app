import 'package:bio_app/features/exam/domain/entities/exam_entity.dart';
import 'package:bio_app/features/exam/domain/entities/exam_question_entity.dart';

abstract class ExamRepo {
  Future<ExamEntity> getExamById(String id);
  Future<ExamQuestionEntity> getExamQuestions(String id);
  Future<void> submitAnswers(
    String examId,
    Map<String, dynamic> answers,
  );
}
