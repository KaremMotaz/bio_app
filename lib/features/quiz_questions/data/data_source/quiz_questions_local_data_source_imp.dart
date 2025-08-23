import '../models/quiz_question_model.dart';
import 'quiz_questions_local_data_source.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/services/local_cache_service.dart';

class QuizQuestionsLocalDataSourceImp
    implements QuizQuestionsLocalDataSource {
  final LocalCacheServicee cache;

  QuizQuestionsLocalDataSourceImp({required this.cache});

  String _keyFor(String quizId) => '$kQuizQuestions:$quizId';

  @override
  Future<List<QuizQuestionModel>?> getQuizQuestions({
    required String quizId,
  }) async {
    final list = await cache.getList(
      key: _keyFor(quizId),
      boxName: kQuizQuestionsBox,
    );
    if (list == null) return null;

    try {
      return list.map((e) => QuizQuestionModel.fromJson(e)).toList();
    } catch (_) {
      await clearQuizQuestions(quizId: quizId);
      return null;
    }
  }

  @override
  Future<void> cacheQuizQuestions({
    required List<QuizQuestionModel> quizQuestions,
    required String quizId,
  }) async {
    final list = quizQuestions.map((c) => c.toJson()).toList();
    await cache.saveList(
      key: _keyFor(quizId),
      boxName: kQuizQuestionsBox,
      list: List<Map<String, dynamic>>.from(list),
    );
  }

  @override
  Future<void> clearQuizQuestions({required String quizId}) async {
    await cache.clear(
      key: _keyFor(quizId),
      boxName: kQuizQuestionsBox,
    );
  }
}
