import 'package:hive/hive.dart';

class LocalCacheService {
  const LocalCacheService();

  Future<List<T>> getList<T>({
    required String boxName,
    required String keyPrefix,
  }) async {
    final box = Hive.box<T>(boxName);
    final items = <T>[];
    for (var key in box.keys) {
      if (key.toString().startsWith(keyPrefix)) {
        final item = box.get(key);
        if (item != null) {
          items.add(item);
        }
      }
    }
    return items;
  }

  Future<T?> getItem<T>({
    required String key,
    required String boxName,
  }) async {
    final box = Hive.box<T>(boxName);
    final data = box.get(key);
    if (data is T) {
      return data;
    }
    return null;
  }

  Future<void> saveList<T>({
    required String boxName,
    required List<T> list,
  }) async {
    final box = Hive.box<T>(boxName);
    for (var i = 0; i < list.length; i++) {
      await box.put('item_$i', list[i]);
    }
  }

  Future<void> saveItem<T>({
    required String key,
    required String boxName,
    required T item,
  }) async {
    final box = Hive.box<T>(boxName);
    await box.put(key, item);
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
