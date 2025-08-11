import '../../../../core/helpers/backend_endpoint.dart';
import '../../../../core/helpers/backend_fields.dart';
import '../../../../core/services/data_service.dart';
import '../models/exam_model.dart';

class ExamsRemoteDataSource {
  final DatabaseService databaseService;

  ExamsRemoteDataSource({required this.databaseService});

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
