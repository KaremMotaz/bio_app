import '../../../../core/helpers/backend_endpoint.dart';
import '../../../../core/helpers/backend_fields.dart';
import '../../../../core/services/data_service.dart';

class ChaptersRemoteDataSource {
  final DatabaseService databaseService;

  ChaptersRemoteDataSource({required this.databaseService});
  Future<List<Map<String, dynamic>>> getFilteredChapters({
    required int unitId,
  }) async {
    final List<Map<String, dynamic>> result = await databaseService
        .getFilteredData(
          path: BackendEndpoint.getChapters,
          field1: BackendFields.unitId,
          value1: unitId,
        );
    return result;
  }
}
