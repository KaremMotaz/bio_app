import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/exam_entity.dart';
import '../../domain/repos/exam_repo.dart';
import '../datasources/exam_remote_data_source.dart';
import '../models/exam_model.dart';

class ExamRepoImpl implements ExamRepo {
  final ExamRemoteDataSource examRemoteDataSource;
  ExamRepoImpl({required this.examRemoteDataSource});

  @override
  Future<ExamEntity> getExamById(String id) =>
      examRemoteDataSource.fetchExam(id);

  @override
  Future<void> submitAnswers(
    String examId,
    Map<String, dynamic> answers,
  ) => examRemoteDataSource.submitAnswers(examId, answers);

  @override
  Future<void> createExam(ExamEntity exam) =>
      examRemoteDataSource.createExam(exam as ExamModel);

  @override
  Future<void> gradeEssay(
    String examId,
    String studentId,
    Map<String, int> essayGrades,
  ) async {
    await FirebaseFirestore.instance
        .collection('submissions')
        .where('examId', isEqualTo: examId)
        .where('studentId', isEqualTo: studentId)
        .get()
        .then((snapshot) {
          for (var doc in snapshot.docs) {
            doc.reference.update({
              'essayGrades': essayGrades,
            });
          }
        });
  }

  @override
  Future<List<ExamEntity>> getPublishedExamsForStudent(
    String studentId,
  ) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('exams')
        .where('isDraft', isEqualTo: false)
        .get();
    return snapshot.docs
        .map(
          (doc) => ExamModel.fromMap(
            doc.data()..['id'] = doc.id,
          ),
        )
        .toList();
  }
}
