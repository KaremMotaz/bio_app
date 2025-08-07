import 'package:bio_app/features/lessons/data/models/quiz_model.dart';

import '../../../../core/helpers/constants.dart';
import '../../../../core/services/local_cache_service.dart';

abstract class QuizzesLocalDataSource {
  Future<List<QuizModel>?> getQuizzes({required int lessonId});
  Future<void> cacheQuizzes({
    required List<QuizModel> quizzes,
    required int lessonId,
  });
  Future<void> clearQuizzes({required int lessonId});
}

class QuizzesLocalDataSourceImpl implements QuizzesLocalDataSource {
  final LocalCacheService cache;

  QuizzesLocalDataSourceImpl({required this.cache});

  String _keyFor(int lessonId) => '$kQuizzes:$lessonId';

  @override
  Future<List<QuizModel>?> getQuizzes({required int lessonId}) async {
    final list = await cache.getList(
      key: _keyFor(lessonId),
      boxName: kQuizzesBox,
    );
    if (list == null) return null;

    try {
      return list.map((e) => QuizModel.fromJson(e)).toList();
    } catch (_) {
      await clearQuizzes(lessonId: lessonId);
      return null;
    }
  }

  @override
  Future<void> cacheQuizzes({
    required List<QuizModel> quizzes,
    required int lessonId,
  }) async {
    final list = quizzes.map((l) => l.toJson()).toList();
    await cache.saveList(
      key: _keyFor(lessonId),
      boxName: kQuizzesBox,
      list: List<Map<String, dynamic>>.from(list),
    );
  }

  @override
  Future<void> clearQuizzes({required int lessonId}) async {
    await cache.clear(key: _keyFor(lessonId), boxName: kQuizzesBox);
  }
}
