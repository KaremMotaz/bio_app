import 'package:bio_app/features/exam_result/domin/repos/exam_result_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExamResultRepoImpl implements ExamResultRepo {
  final FirebaseFirestore firestore;

  ExamResultRepoImpl({required this.firestore});

  @override
  Future<Map<String, int>> getStudentAnswers(String examId) async {
    try {
      final doc = await firestore
          .collection('submissions')
          .doc(examId)
          .get();

      if (!doc.exists) {
        throw Exception('Submission not found');
      }

      final data = doc.data();
      final rawAnswers = data?['answers'] as Map<String, dynamic>?;

      if (rawAnswers == null) return {};

      return rawAnswers.map(
        (key, value) => MapEntry(key.toString(), value as int),
      );
    } catch (e) {
      throw Exception('Failed to fetch student answers: $e');
    }
  }
}
