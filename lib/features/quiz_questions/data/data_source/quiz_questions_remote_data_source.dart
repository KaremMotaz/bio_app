import 'package:bio_app/core/services/firebase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/helpers/backend_endpoint.dart';
import '../../../../core/services/data_service.dart';
import '../models/quiz_question_model.dart';

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
    return result.map((e) => QuizQuestionModel.fromJson(e)).toList();
  }

  Future<void> updateScores({
    required double score,
  }) async {
    await databaseService.editFields(
      collectionName: BackendEndpoint.editFields,
      docId: FirebaseAuthService.userId,
      fields: {
        "scoreThisDay": FieldValue.increment(score),
        "scoreThisWeek": FieldValue.increment(score),
        "scoreThisMonth": FieldValue.increment(score),
      },
    );
  }
}
