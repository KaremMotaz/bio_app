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
}
