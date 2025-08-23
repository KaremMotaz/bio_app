import 'package:bio_app/core/services/local_cache_service.dart';

import 'units_local_data_source.dart';
import '../../../../core/helpers/constants.dart';
import '../models/unit_model.dart';

class UnitsLocalDataSourceImpl implements UnitsLocalDataSource {
  // final LocalCacheService cache;
  final LocalCacheService<UnitModel> cache;

  UnitsLocalDataSourceImpl({required this.cache});

  @override
  Future<List<UnitModel>?> getUnits() async {
    try {
      final List<UnitModel>? list = await cache.getList(
        key: kUnits,
        boxName: kUnitsBox,
      );
      if (list == null) {
        return null;
      }
      return list;
    } catch (e) {
      await clearUnits();
      return null;
    }
  }

  @override
  Future<void> cacheUnits(List<UnitModel> units) async {
    await cache.saveList(
      key: kUnits,
      boxName: kUnitsBox,
      list: units,
    );
  }

  @override
  Future<void> clearUnits() async {
    await cache.clear(key: kUnits, boxName: kUnitsBox);
  }
}
