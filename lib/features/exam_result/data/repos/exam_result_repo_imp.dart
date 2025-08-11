import 'package:bio_app/core/errors/failure.dart';
import 'package:bio_app/core/errors/server_failure.dart';
import 'package:bio_app/features/exam/data/datasources/exam_questions_remote_data_source.dart';
import 'package:bio_app/features/exam/domain/entities/exam_question_entity.dart';
import 'package:bio_app/features/exam_result/data/datasources/exam_result_remote_data_source.dart';
import 'package:dartz/dartz.dart';
import '../../domin/repos/exam_result_repo.dart';

class ExamResultRepoImp implements ExamResultRepo {
  final ExamResultRemoteDataSourceImp examResultRemoteDataSourceImp;
  final ExamQuestionsRemoteDataSource
  examQuestionsRemoteDataSourceImp;

  ExamResultRepoImp({
    required this.examResultRemoteDataSourceImp,
    required this.examQuestionsRemoteDataSourceImp,
  });

  @override
  Future<Either<Failure, List<ExamQuestionEntity>>> getExamQuestions({
    required String examId,
  }) async {
    try {
      
      final List<ExamQuestionEntity> questions =
          await examQuestionsRemoteDataSourceImp.fetchExamQuestions(
            examId: examId,
          );

      return Right(questions);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, int>>>>
  getStudentAnswers() async {
    try {
      final List<Map<String, int>> answers =
          await examResultRemoteDataSourceImp.getStudentAnswers();

      return Right(answers);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
