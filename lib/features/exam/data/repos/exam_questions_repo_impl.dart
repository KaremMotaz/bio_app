import '../../../../core/errors/failure.dart';
import '../../../../core/errors/server_failure.dart';
import '../datasources/exam_questions_remote_data_source.dart';
import '../datasources/exams_questions_local_data_source.dart';
import '../models/exam_question_model.dart';
import '../../domain/entities/exam_question_entity.dart';
import '../../domain/repos/exam_questions_repo.dart';
import 'package:dartz/dartz.dart';

class ExamQuestionsRepoImp implements ExamQuestionsRepo {
  final ExamQuestionsRemoteDataSource examQuestionsRemoteDataSource;
  final ExamsQuestionsLocalDataSource examsQuestionsLocalDataSource;

  ExamQuestionsRepoImp({
    required this.examQuestionsRemoteDataSource,
    required this.examsQuestionsLocalDataSource,
  });

  @override
  Future<Either<Failure, List<ExamQuestionEntity>>> getExamQuestions({
    required String examId,
  }) async {
    try {
      // Try to get data from cache first
      final List<ExamQuestionsModel>? cached =
          await examsQuestionsLocalDataSource.getExamsQuestions();
      if (cached != null && cached.isNotEmpty) {
        return Right(cached);
      }

      //  No data in cache, fetch from remote
      final List<ExamQuestionsModel> examsquestions =
          await examQuestionsRemoteDataSource.fetchExamQuestions(
            examId: examId,
          );

      // Cache the data
      await examsQuestionsLocalDataSource.cacheExamsQuestions(
        examsquestions,
      );

      return Right(examsquestions);
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
      await examQuestionsRemoteDataSource.submitAnswers(
        examId,
        answers,
      );

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
