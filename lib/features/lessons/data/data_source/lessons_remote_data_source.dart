import '../../../../core/helpers/backend_endpoint.dart';
import '../../../../core/helpers/backend_fields.dart';
import '../../../../core/services/data_service.dart';

class LessonsRemoteDataSource {
  final DatabaseService databaseService;

  LessonsRemoteDataSource({required this.databaseService});
  Future<List<Map<String, dynamic>>> getFilteredLessons({
    required int unitSelectedIndex,
    required int chapterSelectedIndex,
  }) async {
    final List<Map<String, dynamic>> result = await databaseService
        .getFilteredData(
          path: BackendEndpoint.getLessons,
          field1: BackendFields.unitId,
          value1: unitSelectedIndex,
          field2: BackendFields.chapterId,
          value2: chapterSelectedIndex,
        );
    return result;
  }
}
