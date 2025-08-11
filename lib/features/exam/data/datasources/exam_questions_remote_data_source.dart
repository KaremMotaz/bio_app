import '../../../../core/helpers/backend_endpoint.dart';
import '../../../../core/services/data_service.dart';
import '../models/exam_question_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExamQuestionsRemoteDataSource {
  final DatabaseService databaseService;

  ExamQuestionsRemoteDataSource({required this.databaseService});

  Future<List<ExamQuestionsModel>> fetchExamQuestions({
    required String examId,
  }) async {
    final List<Map<String, dynamic>> result = await databaseService
        .fetchSubcollection(
          parentCollection: BackendEndpoint.getExams,
          parentDocId: examId,
          subCollection: BackendEndpoint.getExamQuestions,
        );

    return result.map((e) => ExamQuestionsModel.fromJson(e)).toList();
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
