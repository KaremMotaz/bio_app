import '../../../../core/helpers/backend_endpoint.dart';
import '../../../../core/helpers/backend_fields.dart';
import '../../../../core/services/data_service.dart';

class QuizQuestionsRemoteDataSource {
  final DatabaseService databaseService;

  QuizQuestionsRemoteDataSource({required this.databaseService});
  Future<List<Map<String, dynamic>>> getFilteredQuizQuestions({
    required int quizId,
  }) async {
    final List<Map<String, dynamic>> result = await databaseService
        .getFilteredData(
          path: BackendEndpoint.getQuizQuestions,
          field: BackendFields.quizId,
          value: quizId,
        );
    return result;
  }
}
