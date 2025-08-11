import '../models/exam_question_model.dart';

abstract class ExamsQuestionsLocalDataSource {
  Future<List<ExamQuestionsModel>?> getExamsQuestions();
  Future<void> cacheExamsQuestions(
    List<ExamQuestionsModel> examsQuestions,
  );
  Future<void> clearExamsQuestions();
}
