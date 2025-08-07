import '../../../../core/helpers/backend_endpoint.dart';
import '../../../../core/helpers/backend_fields.dart';
import '../../../../core/services/data_service.dart';

class LessonsRemoteDataSource {
  final DatabaseService databaseService;

  LessonsRemoteDataSource({required this.databaseService});
  Future<List<Map<String, dynamic>>> getFilteredLessons({
    required int chapterId,
  }) async {
    final List<Map<String, dynamic>> result = await databaseService
        .getFilteredData(
          path: BackendEndpoint.getLessons,
          field: BackendFields.chapterId,
          value: chapterId,
        );
    return result;
  }
}
