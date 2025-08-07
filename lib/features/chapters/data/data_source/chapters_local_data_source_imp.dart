import 'chapters_local_data_source.dart';
import '../../../../core/helpers/constants.dart';
import '../models/chapter_model.dart';
import '../../../../core/services/local_cache_service.dart';

class ChaptersLocalDataSourceImpl implements ChaptersLocalDataSource {
  final LocalCacheService cache;

  ChaptersLocalDataSourceImpl({required this.cache});

  String _keyFor(int unitId) => '$kChapters:$unitId';

  @override
  Future<List<ChapterModel>?> getChapters({
    required int unitId,
  }) async {
    final list = await cache.getList(
      key: _keyFor(unitId),
      boxName: kChaptersBox,
    );
    if (list == null) return null;

    try {
      return list.map((e) => ChapterModel.fromJson(e)).toList();
    } catch (_) {
      await clearChapters(unitId: unitId);
      return null;
    }
  }

  @override
  Future<void> cacheChapters({
    required List<ChapterModel> chapters,
    required int unitId,
  }) async {
    final list = chapters.map((c) => c.toJson()).toList();
    await cache.saveList(
      key: _keyFor(unitId),
      boxName: kChaptersBox,
      list: List<Map<String, dynamic>>.from(list),
    );
  }

  @override
  Future<void> clearChapters({required int unitId}) async {
    await cache.clear(key: _keyFor(unitId), boxName: kChaptersBox);
  }
}
