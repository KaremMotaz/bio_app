import '../data_source/quiz_questions_local_data_source.dart';
import '../data_source/quiz_questions_remote_data_source.dart';
import '../models/quiz_question_model.dart';
import '../../domain/repos/quiz_questions_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/server_failure.dart';

class QuizQuestionsRepoImp implements QuizQuestionsRepo {
  final QuizQuestionsRemoteDataSource quizQuestionsRemoteDataSource;
  final QuizQuestionsLocalDataSource quizQuestionsLocalDataSource;

  QuizQuestionsRepoImp({
    required this.quizQuestionsRemoteDataSource,
    required this.quizQuestionsLocalDataSource,
  });

  @override
  Future<Either<Failure, List<QuizQuestionModel>>> getQuizQuestions({
    required String quizId,
  }) async {
    try {
      // Try to get from cache first
      final cached = await quizQuestionsLocalDataSource
          .getQuizQuestions(quizId: quizId);
      if (cached != null && cached.isNotEmpty) {
        return Right(cached);
      }

      //  No data in cache, fetch from remote
      final List<QuizQuestionModel> quizQuestions =
          await quizQuestionsRemoteDataSource.getQuizQuestions(
            quizId: quizId,
          );

      // Cache the data
      await quizQuestionsLocalDataSource.cacheQuizQuestions(
        quizQuestions: quizQuestions,
        quizId: quizId,
      );

      return Right(quizQuestions);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
