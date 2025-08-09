import '../../../../core/helpers/backend_endpoint.dart';
import '../../../../core/services/data_service.dart';

class ChaptersRemoteDataSource {
  final DatabaseService databaseService;

  ChaptersRemoteDataSource({required this.databaseService});
  Future<List<Map<String, dynamic>>> getFilteredChapters({
    required String unitId,
  }) async {
    final List<Map<String, dynamic>> result = await databaseService
        .fetchSubcollection(
          parentCollection: BackendEndpoint.getUnits,
          parentDocId: unitId,
          subCollection: BackendEndpoint.getChapters,
        );
    return result;
  }
}
