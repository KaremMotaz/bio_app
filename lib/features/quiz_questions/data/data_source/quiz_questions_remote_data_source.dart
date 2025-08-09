import 'dart:developer';

import 'package:bio_app/features/quiz_questions/data/models/quiz_question_model.dart';

import '../../../../core/helpers/backend_endpoint.dart';
import '../../../../core/services/data_service.dart';

class QuizQuestionsRemoteDataSource {
  final DatabaseService databaseService;

  QuizQuestionsRemoteDataSource({required this.databaseService});
  Future<List<QuizQuestionModel>> getQuizQuestions({
    required String quizId,
  }) async {
    final List<Map<String, dynamic>> result = await databaseService
        .fetchSubcollection(
          parentCollection: BackendEndpoint.getQuizzes,
          subCollection: BackendEndpoint.getQuizQuestions,
          parentDocId: quizId,
        );
    log(result.toString());
    return result.map((e) => QuizQuestionModel.fromJson(e)).toList();
  }
}
