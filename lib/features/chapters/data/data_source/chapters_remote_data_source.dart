import 'package:bio_app/core/helpers/backend_endpoint.dart';
import 'package:bio_app/core/helpers/backend_fields.dart';
import 'package:bio_app/core/services/data_service.dart';

class ChaptersRemoteDataSource {
  final DatabaseService databaseService;

  ChaptersRemoteDataSource({required this.databaseService});
  Future<List<Map<String, dynamic>>> getFilteredChapters({
    required int selectedIndex,
  }) async {
    final List<Map<String, dynamic>> result = await databaseService
        .getFilteredData(
          path: BackendEndpoint.getChapters,
          field: BackendFields.unitId,
          isEqualToValue: selectedIndex,
        );
    return result;
  }
}
