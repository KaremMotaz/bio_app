import '../../../../core/services/local_cache_service.dart';
import 'chapters_local_data_source.dart';
import '../../../../core/helpers/constants.dart';
import '../models/chapter_model.dart';

class ChaptersLocalDataSourceImpl implements ChaptersLocalDataSource {
  final LocalCacheService<ChapterModel> cache;

  ChaptersLocalDataSourceImpl({required this.cache});

  String _keyFor(String unitId) => '$kChapters:$unitId';

  @override
  Future<List<ChapterModel>?> getChapters({
    required String unitId,
  }) async {
    final list = await cache.getList(
      key: _keyFor(unitId),
      boxName: kChaptersBox,
    );
    if (list == null) return null;

    try {
      return list;
    } catch (_) {
      await clearChapters(unitId: unitId);
      return null;
    }
  }

  @override
  Future<void> cacheChapters({
    required List<ChapterModel> chapters,
    required String unitId,
  }) async {
    await cache.saveList(
      key: _keyFor(unitId),
      boxName: kChaptersBox,
      list: chapters,
    );
  }

  @override
  Future<void> clearChapters({required String unitId}) async {
    await cache.clear(key: _keyFor(unitId), boxName: kChaptersBox);
  }
}
