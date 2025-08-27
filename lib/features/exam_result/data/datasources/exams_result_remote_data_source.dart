import 'package:bio_app/core/helpers/get_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/helpers/backend_endpoint.dart';
import '../../../../core/services/data_service.dart';
import '../models/exams_answers_model.dart'; // عدل المسار حسب مشروعك

class ExamsResultRemoteDataSourceImp {
  final DatabaseService databaseService;

  ExamsResultRemoteDataSourceImp({required this.databaseService});

  Future<List<ExamsAnswersModel>> getStudentAnswers() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return [];

    final rawAnswers = await databaseService.getData(
      path:
          '${BackendEndpoint.addUserAnswers}/${currentUser.uid}/${BackendEndpoint.getExamsResults}',
    );

    return rawAnswers.map<ExamsAnswersModel>((map) {
      return ExamsAnswersModel.fromJson(map);
    }).toList();
  }

  Future<void> updateScores({required double score}) async {
    await databaseService.updateData(
      path: '${BackendEndpoint.getUserData}/${getUser().uid}',
      data: {"scoreThisMonth": FieldValue.increment(score)},
    );
  }
}
