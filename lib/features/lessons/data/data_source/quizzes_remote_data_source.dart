import '../models/quiz_model.dart';

import '../../../../core/helpers/backend_endpoint.dart';
import '../../../../core/helpers/backend_fields.dart';
import '../../../../core/services/data_service.dart';

class QuizzesRemoteDataSource {
  final DatabaseService databaseService;

  QuizzesRemoteDataSource({required this.databaseService});
  Future<List<QuizModel>> getFilteredQuizzes({
    required String lessonId,
  }) async {
    final List<Map<String, dynamic>> result = await databaseService
        .getFilteredData(
          path: BackendEndpoint.getQuizzes,
          field: BackendFields.lessonId,
          value: lessonId,
        );

    return result.map((e) => QuizModel.fromJson(e)).toList();
  }
}
