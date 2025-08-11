import 'package:bio_app/features/exam_result/data/models/exams_answers_model.dart';

abstract class ExamsResultLocalDataSource {
  Future<List<ExamsAnswersModel>?> getExamsResult();
  Future<void> cacheExamsResult({
    required List<ExamsAnswersModel> examsResults,
  });
  Future<void> clearExamsResult();
}
