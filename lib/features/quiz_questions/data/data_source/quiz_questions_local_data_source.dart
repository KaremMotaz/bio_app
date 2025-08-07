import 'package:bio_app/features/quiz_questions/data/models/quiz_question_model.dart';

abstract class QuizQuestionsLocalDataSource {
  Future<List<QuizQuestionModel>?> getQuizQuestions({
    required int quizId,
  });
  Future<void> cacheQuizQuestions({
    required List<QuizQuestionModel> quizQuestions,
    required int quizId,
  });
  Future<void> clearQuizQuestions({required int quizId});
}
