import '../models/chapter_model.dart';

abstract class ChaptersLocalDataSource {
  Future<List<ChapterModel>?> getChapters({required int unitId});
  Future<void> cacheChapters({
    required List<ChapterModel> chapters,
    required int unitId,
  });
  Future<void> clearChapters({required int unitId});
}
