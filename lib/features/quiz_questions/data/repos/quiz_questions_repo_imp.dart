import 'package:bio_app/features/quiz_questions/data/data_source/quiz_questions_local_data_source.dart';
import 'package:bio_app/features/quiz_questions/data/data_source/quiz_questions_remote_data_source.dart';
import 'package:bio_app/features/quiz_questions/data/models/quiz_question_model.dart';
import 'package:bio_app/features/quiz_questions/domain/repos/quiz_questions_repo.dart';
import 'package:dartz/dartz.dart';
import 'dart:developer';
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
      final List<Map<String, dynamic>> result =
          await quizQuestionsRemoteDataSource.getFilteredQuizQuestions(
            quizId: quizId,
          );
      final List<QuizQuestionModel> quizQuestions = result
          .map((json) => QuizQuestionModel.fromJson(json))
          .toList();

      // Cache the data
      await quizQuestionsLocalDataSource.cacheQuizQuestions(
        quizQuestions: quizQuestions,
        quizId: quizId,
      );

      return Right(quizQuestions);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }
}
