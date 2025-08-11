import 'package:bio_app/core/helpers/backend_endpoint.dart';
import 'package:bio_app/core/services/data_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExamResultRemoteDataSourceImp {
  final DatabaseService databaseService;

  ExamResultRemoteDataSourceImp({required this.databaseService});

  Future<List<Map<String, int>>> getStudentAnswers() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return [];

    final rawAnswers = await databaseService.fetchSubcollection(
      parentCollection: BackendEndpoint.addUserAnswers,
      parentDocId: currentUser.uid,
      subCollection: BackendEndpoint.getExamsResults,
    );

    return rawAnswers
        .map<Map<String, int>>(
          (map) => Map<String, int>.from(map['answers'] ?? {}),
        )
        .toList();
  }
}
