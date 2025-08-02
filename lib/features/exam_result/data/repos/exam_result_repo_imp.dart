import '../../domin/repos/exam_result_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExamResultRepoImpl implements ExamResultRepo {
  final FirebaseFirestore firestore;

  ExamResultRepoImpl({required this.firestore});

@override
Future<Map<String, int>> getStudentAnswers(String examId) async {
  try {
    final querySnapshot = await firestore
        .collection('submissions')
        .where('examId', isEqualTo: examId)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      throw Exception('Submission not found');
    }

    final data = querySnapshot.docs.first.data();
    final rawAnswers = data['answers'] as Map<String, dynamic>?;

    if (rawAnswers == null) return {};

    return rawAnswers.map(
      (key, value) => MapEntry(key.toString(), value as int),
    );
  } catch (e) {
    throw Exception('Failed to fetch student answers: $e');
  }
}

}
