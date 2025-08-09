import 'package:bio_app/features/lessons/data/models/quiz_model.dart';

import '../../../../core/helpers/backend_endpoint.dart';
import '../../../../core/helpers/backend_fields.dart';
import '../../../../core/services/data_service.dart';

class QuizzesRemoteDataSource {
  final DatabaseService databaseService;

  QuizzesRemoteDataSource({required this.databaseService});
  Future<List<QuizModel>> getFilteredQuizzes({
    required int lessonId,
  }) async {
    final List<QuizModel> result = await databaseService
        .getFilteredData(
          path: BackendEndpoint.getQuizzes,
          field: BackendFields.lessonId,
          value: lessonId,
          fromDocument: (doc) => QuizModel.fromDocument(doc),
        );
    return result;
  }
}
