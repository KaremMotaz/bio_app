import '../models/lesson_model.dart';

abstract class LessonsLocalDataSource {
  Future<List<LessonModel>?> getLessons({required int chapterId});
  Future<void> cacheLessons({
    required List<LessonModel> lessons,
    required int chapterId,
  });
  Future<void> clearLessons({required int chapterId});
}