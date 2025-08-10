import 'package:bio_app/core/helpers/backend_endpoint.dart';
import 'package:bio_app/core/services/data_service.dart';
import 'package:bio_app/features/exam_questions/data/models/exam_question_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExamQuestionsRemoteDataSource {
  final DatabaseService databaseService;

  ExamQuestionsRemoteDataSource({required this.databaseService});

  Future<List<ExamQuestionModel>> fetchExamQuestions({
    required String examId,
  }) async {
    final List<Map<String, dynamic>> result = await databaseService
        .fetchSubcollection(
          parentCollection: BackendEndpoint.getExams,
          parentDocId: examId,
          subCollection: BackendEndpoint.getExamQuestions,
        );

    return result.map((e) => ExamQuestionModel.fromJson(e)).toList();
  }

  Future<void> submitAnswers(
    String examId,
    Map<String, int> answers,
  ) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    final baseData = {
      'answers': answers,
      'timestamp': FieldValue.serverTimestamp(),
    };

    final userData = Map<String, dynamic>.from(baseData);

    final examData = {...baseData, 'userId': currentUser.uid};

    await Future.wait([
      databaseService.addToSubcollection(
        parentCollection: BackendEndpoint.addUserAnswers,
        parentDocId: currentUser.uid,
        subCollection: BackendEndpoint.getExamsResults,
        data: userData,
      ),
      databaseService.addToSubcollection(
        parentCollection: BackendEndpoint.getExams,
        parentDocId: examId,
        subCollection: BackendEndpoint.getExamResults,
        data: examData,
      ),
    ]);
  }
}
