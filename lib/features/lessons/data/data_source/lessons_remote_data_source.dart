import 'package:bio_app/core/helpers/backend_endpoint.dart';
import 'package:bio_app/core/helpers/backend_fields.dart';
import 'package:bio_app/core/services/data_service.dart';

class LessonsRemoteDataSource {
  final DatabaseService databaseService;

  LessonsRemoteDataSource({required this.databaseService});
  Future<List<Map<String, dynamic>>> getFilteredLessons({
    required int selectedIndex,
  }) async {
    final List<Map<String, dynamic>> result = await databaseService
        .getFilteredData(
          path: BackendEndpoint.getLessons,
          field: BackendFields.chapterId,
          isEqualToValue: selectedIndex,
        );
    return result;
  }
}
