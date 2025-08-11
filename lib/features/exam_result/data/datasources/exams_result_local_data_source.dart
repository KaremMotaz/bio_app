import 'package:bio_app/features/exam_result/data/models/answers_model.dart';

abstract class ExamResultLocalDataSource {
  Future<List<AnswersModel>?> getExamsResult();
  Future<void> cacheExamsResult(List<AnswersModel> exams);
  Future<void> clearExamsResult();
}
