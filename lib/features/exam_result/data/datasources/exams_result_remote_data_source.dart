import '../../../../core/helpers/get_user.dart';
import '../../../../core/services/cache_helper.dart';
import '../../../../core/services/firebase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/helpers/backend_endpoint.dart';
import '../../../../core/services/data_service.dart';
import '../models/exams_answers_model.dart'; 

class ExamsResultRemoteDataSourceImp {
  final DatabaseService databaseService;

  ExamsResultRemoteDataSourceImp({required this.databaseService});

  Future<List<ExamsAnswersModel>> getStudentAnswers() async {
    if (FirebaseAuthService.currentUser == null) return [];

    final rawAnswers = await databaseService.getData(
      path:
          '${BackendEndpoint.getUserData}/${getUser().uid}/${BackendEndpoint.getExamsResults}',
    );

    return rawAnswers.map<ExamsAnswersModel>((map) {
      return ExamsAnswersModel.fromJson(map);
    }).toList();
  }

  Future<void> updateScores({
    required double score,
    required String examId,
    required bool isResultViewed,
  }) async {
    final localViewed = CacheHelper.getBool(
      key: "exam_${examId}_resultViewed",
    );
    if (!localViewed) {
      if (!isResultViewed) {
        await databaseService.updateData(
          path: '${BackendEndpoint.getUserData}/${getUser().uid}',
          data: {"scoreThisMonth": FieldValue.increment(score)},
        );
        await databaseService.updateData(
          path:
              '${BackendEndpoint.updateUserData}/${getUser().uid}/${BackendEndpoint.getExamsResults}/$examId',
          data: {"isResultViewed": true},
        );
        await CacheHelper.set(
          key: "exam_${examId}_resultViewed",
          value: true,
        );
      }
    }
  }
}
