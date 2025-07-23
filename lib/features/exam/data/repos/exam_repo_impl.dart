import 'package:bio_app/features/exam/data/datasources/exam_remote_data_source.dart';
import 'package:bio_app/features/exam/data/models/exam_model.dart';
import 'package:bio_app/features/exam/domain/entities/exam.dart';
import 'package:bio_app/features/exam/domain/entities/exam_result.dart';
import 'package:bio_app/features/exam/domain/repos/exam_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExamRepoImpl implements ExamRepo {
  final ExamRemoteDataSource examRemoteDataSource;
  ExamRepoImpl({required this.examRemoteDataSource});

  @override
  Future<Exam> getExamById(String id) => examRemoteDataSource.fetchExam(id);

  @override
  Future<ExamResultEntity> submitAnswers(String examId, Map<String, dynamic> answers) =>
      examRemoteDataSource.submitAnswers(examId, answers);

  @override
  Future<void> createExam(Exam exam) =>
      examRemoteDataSource.createExam(exam as ExamModel);

  @override
  Future<void> gradeEssay(String examId, String studentId, Map<String, int> essayGrades) async {
    await FirebaseFirestore.instance
        .collection('submissions')
        .where('examId', isEqualTo: examId)
        .where('studentId', isEqualTo: studentId)
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference.update({'essayGrades': essayGrades});
      }
    });
  }

  @override
  Future<List<Exam>> getPublishedExamsForStudent(String studentId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('exams')
        .where('isDraft', isEqualTo: false)
        .get();
    return snapshot.docs.map((doc) => ExamModel.fromMap(doc.data()..['id'] = doc.id)).toList();
  }
}