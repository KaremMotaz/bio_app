import 'dart:developer';
import 'package:bio_app/core/errors/failure.dart';
import 'package:bio_app/core/errors/server_failure.dart';
import 'package:bio_app/features/lessons/data/data_source/quizzes_local_data_source.dart';
import 'package:bio_app/features/lessons/data/data_source/quizzes_remote_data_source.dart';
import 'package:bio_app/features/lessons/data/models/quiz_model.dart';
import 'package:bio_app/features/lessons/domain/quiz_repo.dart';
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
