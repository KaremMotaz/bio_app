import '../../../../core/helpers/backend_endpoint.dart';
import '../../../../core/services/data_service.dart';

class UnitsRemoteDataSource {
  final DatabaseService databaseService;

  UnitsRemoteDataSource({required this.databaseService});
  Future<List<Map<String, dynamic>>> getUnits() async {
    final result = await databaseService.getData(
      path: BackendEndpoint.getUnits,
    );
    return result;
  }
}
