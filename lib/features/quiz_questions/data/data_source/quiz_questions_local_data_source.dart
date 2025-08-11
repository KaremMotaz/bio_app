import '../models/quiz_question_model.dart';

abstract class QuizQuestionsLocalDataSource {
  Future<List<QuizQuestionModel>?> getQuizQuestions({
    required String quizId,
  });
  Future<void> cacheQuizQuestions({
    required List<QuizQuestionModel> quizQuestions,
    required String quizId,
  });
  Future<void> clearQuizQuestions({required String quizId});
}
