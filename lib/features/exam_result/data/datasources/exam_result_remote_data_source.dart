import 'package:bio_app/core/helpers/backend_endpoint.dart';
import 'package:bio_app/core/helpers/backend_fields.dart';
import 'package:bio_app/core/services/data_service.dart';
import 'package:bio_app/features/exam_questions/data/models/exam_model.dart';
import 'package:bio_app/features/exam_questions/data/models/exam_question_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExamResultRemoteDataSourceImp {
  final DatabaseService databaseService;

  ExamResultRemoteDataSourceImp({required this.databaseService});

  Future<List<ExamModel>> fetchExam() async {
    final List<Map<String, dynamic>> result = await databaseService
        .getFilteredData(
          path: BackendEndpoint.getExams,
          field: BackendFields.isPublished,
          value: true,
        );
    return result.map((e) => ExamModel.fromJson(e)).toList();
  }

  Future<List<ExamQuestionModel>> fetchExamQuestions({
    required String examId,
  }) async {
    final List<Map<String, dynamic>> result = await databaseService
        .fetchSubcollection(
          parentCollection: BackendEndpoint.getExams,
          parentDocId: examId,
          subCollection: BackendEndpoint.getExamQuestions,
        );

    return result.map((e) => ExamQuestionModel.fromJson(e)).toList();
  }

  Future<List<Map<String, int>>> getStudentAnswers() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return [];

    final List<Map<String, dynamic>> rawAnswers =
        await databaseService.fetchSubcollection(
          parentCollection: BackendEndpoint.addUserAnswers,
          parentDocId: currentUser.uid,
          subCollection: BackendEndpoint.getExamsResults,
        );

    final List<Map<String, int>> studentAnswers = rawAnswers.map((
      map,
    ) {
      final filtered = <String, int>{};

      map.forEach((key, value) {
        if (value is int) {
          filtered[key] = value;
        }
      });

      return filtered;
    }).toList();

    return studentAnswers;
  }
}
