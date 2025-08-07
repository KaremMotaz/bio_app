import 'dart:developer';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/server_failure.dart';
import '../data_source/quizzes_local_data_source.dart';
import '../data_source/quizzes_remote_data_source.dart';
import '../models/quiz_model.dart';
import '../../domain/quiz_repo.dart';
import 'package:dartz/dartz.dart';

class QuizRepoImp implements QuizRepo {
  final QuizzesRemoteDataSource quizzesRemoteDataSource;
  final QuizzesLocalDataSource quizzesLocalDataSource;

  QuizRepoImp({
    required this.quizzesRemoteDataSource,
    required this.quizzesLocalDataSource,
  });

  @override
  Future<Either<Failure, List<QuizModel>>> getQuizzes({
    required int lessonId,
  }) async {
    try {
      // Try to get from cache first
      final cached = await quizzesLocalDataSource.getQuizzes(
        lessonId: lessonId,
      );
      if (cached != null && cached.isNotEmpty) {
        return Right(cached);
      }

      //  No data in cache, fetch from remote
      final List<Map<String, dynamic>> result =
          await quizzesRemoteDataSource.getFilteredQuizzes(
            lessonId: lessonId,
          );
      final List<QuizModel> quizzes = result
          .map((json) => QuizModel.fromJson(json))
          .toList();

      // Cache the data
      await quizzesLocalDataSource.cacheQuizzes(
        quizzes: quizzes,
        lessonId: lessonId,
      );

      return Right(quizzes);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }
}
