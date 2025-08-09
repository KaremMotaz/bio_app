import '../models/chapter_model.dart';

abstract class ChaptersLocalDataSource {
  Future<List<ChapterModel>?> getChapters({required String unitId});
  Future<void> cacheChapters({
    required List<ChapterModel> chapters,
    required String unitId,
  });
  Future<void> clearChapters({required String unitId});
}
