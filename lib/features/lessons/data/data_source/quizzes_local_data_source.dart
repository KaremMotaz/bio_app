import '../models/quiz_model.dart';

abstract class QuizzesLocalDataSource {
  Future<List<QuizModel>?> getQuizzes({required String lessonId});
  Future<void> cacheQuizzes({
    required List<QuizModel> quizzes,
    required String lessonId,
  });
  Future<void> clearQuizzes({required String lessonId});
}
