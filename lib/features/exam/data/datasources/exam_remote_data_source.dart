import 'package:bio_app/core/services/firestore_service.dart';

import '../../../../core/helpers/backend_endpoint.dart';
import '../../../../core/helpers/backend_fields.dart';
import '../../../../core/services/data_service.dart';
import '../models/exam_model.dart';

class ExamsRemoteDataSource {
  final DatabaseService databaseService;

  ExamsRemoteDataSource({required this.databaseService});

  Future<List<ExamModel>> fetchExam() async {
    final List<Map<String, dynamic>> result = await databaseService
        .getData(
          path: BackendEndpoint.getExams,
          filters: [FilterCondition(BackendFields.isPublished, true)],
        );
    return result.map((e) => ExamModel.fromJson(e)).toList();
  }
}
