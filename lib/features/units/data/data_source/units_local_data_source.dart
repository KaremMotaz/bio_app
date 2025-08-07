import '../models/unit_model.dart';

abstract class UnitsLocalDataSource {
  Future<List<UnitModel>?> getUnits();
  Future<void> cacheUnits(List<UnitModel> units);
  Future<void> clearUnits();
}