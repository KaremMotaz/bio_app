import 'package:bio_app/core/errors/failure.dart';
import 'package:bio_app/core/errors/server_failure.dart';
import 'package:bio_app/features/exam_questions/data/datasources/exam_questions_remote_data_source.dart';
import 'package:bio_app/features/exam_questions/domain/entities/exam_question_entity.dart';
import 'package:bio_app/features/exam_questions/domain/repos/exam_questions_repo.dart';
import 'package:dartz/dartz.dart';

class ExamQuestionsRepoImpl implements ExamQuestionsRepo {
  final ExamQuestionsRemoteDataSource examQuestionsRemoteDataSource;

  ExamQuestionsRepoImpl({required this.examQuestionsRemoteDataSource});

  @override
  Future<Either<Failure, List<ExamQuestionEntity>>> getExamQuestions({
    required String examId,
  }) async {
    try {
      final List<ExamQuestionEntity> questions =
          await examQuestionsRemoteDataSource.fetchExamQuestions(
            examId: examId,
          );

      return Right(questions);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> submitAnswers({
    required String examId,
    required Map<String, int> answers,
  }) async {
    try {
      await examQuestionsRemoteDataSource.submitAnswers(examId, answers);

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
