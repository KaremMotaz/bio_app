import '../models/exam_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExamRemoteDataSource {
  final FirebaseFirestore firestore;
  ExamRemoteDataSource({required this.firestore});

  Future<ExamModel> fetchExam(String id) async {
    final doc = await firestore
        .collection('exams')
        .doc(id)
        .get();
    return ExamModel.fromMap(doc.data()!..['id'] = doc.id);
  }

  Future<void> submitAnswers(
    String examId,
    Map<String, dynamic> answers,
  ) async {
    await firestore.collection('submissions').add({
      'examId': examId,
      'answers': answers,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  Future<void> createExam(ExamModel model) async {
    final docRef = firestore.collection('exams').doc();
    await firestore
        .collection('exams')
        .doc(docRef.id)
        .set(model.toMap(id: docRef.id));
  }
}
