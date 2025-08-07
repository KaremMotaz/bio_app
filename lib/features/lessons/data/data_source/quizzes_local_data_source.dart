import '../models/quiz_model.dart';

abstract class QuizzesLocalDataSource {
  Future<List<QuizModel>?> getQuizzes({required int lessonId});
  Future<void> cacheQuizzes({
    required List<QuizModel> quizzes,
    required int lessonId,
  });
  Future<void> clearQuizzes({required int lessonId});
}