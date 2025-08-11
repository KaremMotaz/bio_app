import '../models/exam_model.dart';

abstract class ExamsLocalDataSource {
  Future<List<ExamModel>?> getExams();
  Future<void> cacheExams(List<ExamModel> exams);
  Future<void> clearExams();
}
