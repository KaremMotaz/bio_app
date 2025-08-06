import 'package:bio_app/core/helpers/constants.dart';
import 'package:bio_app/core/services/local_cache_service.dart';
import 'package:bio_app/features/lessons/data/models/lesson_model.dart';

abstract class LessonsLocalDataSource {
  Future<List<LessonModel>?> getLessons({required int chapterId});
  Future<void> cacheLessons({
    required List<LessonModel> lessons,
    required int chapterId,
  });
  Future<void> clearLessons({required int chapterId});
}

class LessonsLocalDataSourceImpl implements LessonsLocalDataSource {
  final LocalCacheService cache;

  LessonsLocalDataSourceImpl({required this.cache});

  String _keyFor(int chapterId) => '$kLessons:$chapterId';

  @override
  Future<List<LessonModel>?> getLessons({
    required int chapterId,
  }) async {
    final list = await cache.getList(
      key: _keyFor(chapterId),
      boxName: kLessonsBox,
    );
    if (list == null) return null;

    try {
      return list.map((e) => LessonModel.fromJson(e)).toList();
    } catch (_) {
      await clearLessons(chapterId: chapterId);
      return null;
    }
  }

  @override
  Future<void> cacheLessons({
    required List<LessonModel> lessons,
    required int chapterId,
  }) async {
    final list = lessons.map((l) => l.toJson()).toList();
    await cache.saveList(
      key: _keyFor(chapterId),
      boxName: kLessonsBox,
      list: List<Map<String, dynamic>>.from(list),
    );
  }

  @override
  Future<void> clearLessons({required int chapterId}) async {
    await cache.clear(key: _keyFor(chapterId), boxName: kLessonsBox);
  }
}
