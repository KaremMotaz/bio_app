import '../../../../core/helpers/backend_endpoint.dart';
import '../../../../core/helpers/backend_fields.dart';
import '../../../../core/services/data_service.dart';

class QuizzesRemoteDataSource {
  final DatabaseService databaseService;

  QuizzesRemoteDataSource({required this.databaseService});
  Future<List<Map<String, dynamic>>> getFilteredQuizzes({
    required int lessonId,
  }) async {
    final List<Map<String, dynamic>> result = await databaseService
        .getFilteredData(
          path: BackendEndpoint.getQuizzes,
          field1: BackendFields.lessonId,
          value1: lessonId,
        );
    return result;
  }
}
