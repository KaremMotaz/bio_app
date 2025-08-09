import '../models/lesson_model.dart';

abstract class LessonsLocalDataSource {
  Future<List<LessonModel>?> getLessons({
    required String chapterId,
    required String unitId,
  });
  Future<void> cacheLessons({
    required List<LessonModel> lessons,
    required String chapterId,
    required String unitId,
  });
  Future<void> clearLessons({
    required String chapterId,
    required String unitId,
  });
}
