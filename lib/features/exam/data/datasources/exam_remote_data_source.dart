import 'package:bio_app/features/exam/data/models/exam_question_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/exam_model.dart';

class ExamRemoteDataSource {
  final FirebaseFirestore firestore;
  ExamRemoteDataSource({required this.firestore});

  Future<ExamModel> fetchExam(String id) async {
    final doc = await firestore.collection('exams').doc(id).get();
    return ExamModel.fromMap(doc.data()!..['id'] = doc.id);
  }

  Future<List<ExamQuestionModel>> fetchExamQuestions(String id) async {
    final doc = await firestore.collection('exams').doc(id).get();
    return List<ExamQuestionModel>.fromMap(doc.data()!..['id'] = doc.id);
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
}
