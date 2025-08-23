import 'package:bio_app/core/services/local_cache_service.dart';
import 'lessons_local_data_source.dart';
import '../../../../core/helpers/constants.dart';
import '../models/lesson_model.dart';

class LessonsLocalDataSourceImpl implements LessonsLocalDataSource {
  final LocalCacheService<LessonModel> cache;

  LessonsLocalDataSourceImpl({required this.cache});

  String _keyFor(String chapterId, String unitId) =>
      '$kLessons:$unitId:$chapterId';

  @override
  Future<List<LessonModel>?> getLessons({
    required String chapterId,
    required String unitId,
  }) async {
    final list = await cache.getList(
      key: _keyFor(chapterId, unitId),
      boxName: kLessonsBox,
    );
    if (list == null) return null;

    try {
      return list;
    } catch (_) {
      await clearLessons(chapterId: chapterId, unitId: unitId);
      return null;
    }
  }

  @override
  Future<void> cacheLessons({
    required List<LessonModel> lessons,
    required String chapterId,
    required String unitId,
  }) async {
    await cache.saveList(
      key: _keyFor(chapterId, unitId),
      boxName: kLessonsBox,
      list: lessons,
    );
  }

  @override
  Future<void> clearLessons({
    required String chapterId,
    required String unitId,
  }) async {
    await cache.clear(
      key: _keyFor(chapterId, unitId),
      boxName: kLessonsBox,
    );
  }
}
