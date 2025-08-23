import 'package:hive/hive.dart';

class LocalCacheServicee {
  LocalCacheServicee();

  Future<List<Map<String, dynamic>>?> getList({
    required String key,
    required String boxName,
  }) async {
    final box = Hive.box(boxName);
    final data = box.get(key);
    if (data is! List) return null;

    try {
      final List<Map<String, dynamic>> normalized = data
          .map<Map<String, dynamic>>((e) {
            if (e is Map) {
              return e.map<String, dynamic>(
                (k, v) => MapEntry(k.toString(), v),
              );
            }
            throw const FormatException('List item is not a Map');
          })
          .toList();
      return normalized;
    } catch (_) {
      return null;
    }
  }

  Future<void> saveList({
    required String key,
    required String boxName,
    required List<Map<String, dynamic>> list,
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
