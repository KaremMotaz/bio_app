import 'package:bio_app/core/helpers/backend_endpoint.dart';
import 'package:bio_app/core/services/data_service.dart';

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
