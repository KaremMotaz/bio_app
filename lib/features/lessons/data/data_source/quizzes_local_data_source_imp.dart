import '../../../../core/services/local_cache_service.dart';
import '../../../../core/helpers/constants.dart';
import '../models/quiz_model.dart';
import 'quizzes_local_data_source.dart';

class QuizzesLocalDataSourceImpl implements QuizzesLocalDataSource {
  final LocalCacheService<QuizModel> cache;

  QuizzesLocalDataSourceImpl({required this.cache});

  String _keyFor(String lessonId) => '$kQuizzes:$lessonId';

  @override
  Future<List<QuizModel>?> getQuizzes({
    required String lessonId,
  }) async {
    final List<QuizModel>? list = await cache.getList(
      key: _keyFor(lessonId),
      boxName: kQuizzesBox,
    );
    if (list == null) return null;

    try {
      return list;
    } catch (_) {
      await clearQuizzes(lessonId: lessonId);
      return null;
    }
  }

  @override
  Future<void> cacheQuizzes({
    required List<QuizModel> quizzes,
    required String lessonId,
  }) async {
    await cache.saveList(
      key: _keyFor(lessonId),
      boxName: kQuizzesBox,
      list: quizzes,
    );
  }

  @override
  Future<void> clearQuizzes({required String lessonId}) async {
    await cache.clear(key: _keyFor(lessonId), boxName: kQuizzesBox);
  }
}
