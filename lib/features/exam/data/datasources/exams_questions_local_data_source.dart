import 'package:bio_app/features/exam/data/models/exam_question_model.dart';

abstract class ExamsQuestionsLocalDataSource {
  Future<List<ExamQuestionsModel>?> getExamsQuestions();
  Future<void> cacheExamsQuestions(
    List<ExamQuestionsModel> examsQuestions,
  );
  Future<void> clearExamsQuestions();
}
