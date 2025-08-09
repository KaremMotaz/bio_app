import '../../../../core/helpers/backend_endpoint.dart';
import '../../../../core/services/data_service.dart';

class QuizQuestionsRemoteDataSource {
  final DatabaseService databaseService;

  QuizQuestionsRemoteDataSource({required this.databaseService});
  Future<List<Map<String, dynamic>>> getFilteredQuizQuestions({
    required String quizId,
  }) async {
    final List<Map<String, dynamic>> result = await databaseService
        .fetchSubcollection(
          parentCollection: BackendEndpoint.getQuizzes,
          subCollection: BackendEndpoint.getQuizQuestions,
          parentDocId: quizId,
        );
    return result;
  }
}
