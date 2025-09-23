import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/helpers/backend_endpoint.dart';
import '../../../../core/helpers/get_user.dart';
import '../../../../core/services/data_service.dart';
import '../../../../core/services/firebase_auth_service.dart';
import '../models/exam_question_model.dart';

class ExamQuestionsRemoteDataSource {
  final DatabaseService databaseService;

  ExamQuestionsRemoteDataSource({required this.databaseService});

  Future<List<ExamQuestionsModel>> getExamQuestions({
    required String examId,
  }) async {
    final List<Map<String, dynamic>>
    result = await databaseService.getData(
      path:
          '${BackendEndpoint.getExams}/$examId/${BackendEndpoint.getExamQuestions}',
    );

    return result.map((e) => ExamQuestionsModel.fromJson(e)).toList();
  }

  Future<void> submitAnswers(
    String examId,
    Map<String, int> answers,
  ) async {
    if (FirebaseAuthService.currentUser == null) return;

    final baseData = {
      'answers': answers,
      'isResultViewed': false,
      'timestamp': FieldValue.serverTimestamp(),
    };

    final userData = Map<String, dynamic>.from(baseData);

    final examData = {...baseData, 'userId': getUser().uid};

    await Future.wait([
      databaseService.addData(
        path:
            '${BackendEndpoint.addUserAnswers}/${getUser().uid}/${BackendEndpoint.getExamsResults}',
        data: userData,
      ),
      databaseService.addData(
        path:
            '${BackendEndpoint.getExams}/$examId/${BackendEndpoint.getExamResults}',
        data: examData,
      ),
    ]);
  }
}
