import 'units_local_data_source.dart';
import '../../../../core/helpers/constants.dart';
import '../models/unit_model.dart';
import '../../../../core/services/local_cache_service.dart';

class UnitsLocalDataSourceImpl implements UnitsLocalDataSource {
  final LocalCacheService cache;

  UnitsLocalDataSourceImpl({required this.cache});

  @override
  Future<List<UnitModel>?> getUnits() async {
    final list = await cache.getList(key: kUnits, boxName: kUnitsBox);
    if (list == null) return null;

    try {
      return list.map((e) => UnitModel.fromJson(e)).toList();
    } catch (_) {
      await clearUnits();
      return null;
    }
  }

  @override
  Future<void> cacheUnits(List<UnitModel> units) async {
    final list = units.map((u) => u.toJson()).toList();
    await cache.saveList(
      key: kUnits,
      boxName: kUnitsBox,
      list: List<Map<String, dynamic>>.from(list),
    );
  }

  @override
  Future<void> clearUnits() async {
    await cache.clear(key: kUnits, boxName: kUnitsBox);
  }
}
