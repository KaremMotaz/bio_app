import '../../../../core/helpers/backend_endpoint.dart';
import '../../../../core/services/data_service.dart';
import '../models/unit_model.dart';

class UnitsRemoteDataSource {
  final DatabaseService databaseService;

  UnitsRemoteDataSource({required this.databaseService});
  Future<List<UnitModel>> getUnits() async {
    final List<Map<String, dynamic>> result = await databaseService
        .getData(path: BackendEndpoint.getUnits);

    return result.map((e) => UnitModel.fromJson(e)).toList();
  }
}
