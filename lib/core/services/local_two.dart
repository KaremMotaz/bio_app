import 'package:hive/hive.dart';

class LocalCacheService<T> {
  Future<List<T>?> getList({
    required String key,
    required String boxName,
  }) async {
    final box = Hive.box(boxName);
    final data = box.get(key);
    if (data is! List) return null;
    return data.cast<T>();
  }

  Future<void> saveList({
    required String key,
    required String boxName,
    required List<T> list,
  }) async {
    final box = Hive.box(boxName);
    await box.put(key, list);
  }

  Future<void> clear({
    required String key,
    required String boxName,
  }) async {
    final box = Hive.box(boxName);
    await box.delete(key);
  }

  Future<void> clearAll({required String boxName}) async {
    final box = Hive.box(boxName);
    await box.clear();
  }
}
