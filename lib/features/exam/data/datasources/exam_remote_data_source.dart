import 'package:bio_app/core/helpers/get_user.dart';

import '../../../../core/services/firestore_service.dart';

import '../../../../core/helpers/backend_endpoint.dart';
import '../../../../core/helpers/backend_fields.dart';
import '../../../../core/services/data_service.dart';
import '../models/exam_model.dart';

class ExamsRemoteDataSource {
  final DatabaseService databaseService;

  ExamsRemoteDataSource({required this.databaseService});

  Future<List<ExamModel>> getExams() async {
    final List<Map<String, dynamic>> result = await databaseService
        .getData(
          path: BackendEndpoint.getExams,
          filters: [
            FilterCondition(BackendFields.isPublished, true),
          ],
        );
    return result.map((e) => ExamModel.fromJson(e)).toList();
  }

  Future<void> markExamAsOpened({required String examId}) async {
    await databaseService.addData(
      path:
          '${BackendEndpoint.addUserData}/${getUser().uid}/${BackendEndpoint.markExamAsOpened}',
      documentId: examId,
      data: {
        'examId': examId,
        'openedAt': DateTime.now().toIso8601String(),
        'status': true,
      },
    );
  }

  Future<Map<String, bool>> getOpenedExamsStatus() async {
    final result = await databaseService.getData(
      path:
          '${BackendEndpoint.getUserData}/${getUser().uid}/${BackendEndpoint.markExamAsOpened}',
    );
    return {
      for (var doc in result)
        doc['id'] as String: doc['status'] as bool,
    };
  }
}
