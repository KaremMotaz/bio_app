import 'package:bio_app/core/helpers/backend_endpoint.dart';
import 'package:bio_app/core/helpers/backend_fields.dart';
import 'package:bio_app/core/services/data_service.dart';
import '../models/exam_model.dart';

class ExamRemoteDataSource {
  final DatabaseService databaseService;

  ExamRemoteDataSource({required this.databaseService});

  Future<List<ExamModel>> fetchExam() async {
    final List<Map<String, dynamic>> result = await databaseService
        .getFilteredData(
          path: BackendEndpoint.getExams,
          field: BackendFields.isPublished,
          value: true,
        );
    return result.map((e) => ExamModel.fromJson(e)).toList();
  }
}
