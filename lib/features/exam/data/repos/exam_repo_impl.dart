import '../../domain/entities/exam_entity.dart';
import '../../domain/repos/exam_repo.dart';
import '../datasources/exam_remote_data_source.dart';

class ExamRepoImpl implements ExamRepo {
  final ExamRemoteDataSource examRemoteDataSource;
  ExamRepoImpl({required this.examRemoteDataSource});

  @override
  Future<ExamEntity> getExamById(String id) {
    return examRemoteDataSource.fetchExam(id);
  }

  @override
  Future<void> submitAnswers(
    String examId,
    Map<String, dynamic> answers,
  ) {
    return examRemoteDataSource.submitAnswers(
      examId,
      answers,
    );
  }
}
