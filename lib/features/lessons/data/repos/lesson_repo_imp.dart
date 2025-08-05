import 'dart:developer';
import 'package:bio_app/core/errors/server_failure.dart';
import 'package:bio_app/features/lessons/data/data_source/lessons_remote_data_source.dart';
import 'package:bio_app/features/lessons/data/models/lesson_model.dart';
import 'package:bio_app/features/lessons/domain/lesson_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:bio_app/core/errors/failure.dart';

class LessonRepoImp implements LessonRepo {
  LessonsRemoteDataSource lessonsRemoteDataSource;
  LessonRepoImp({required this.lessonsRemoteDataSource});

  @override
  Future<Either<Failure, List<LessonModel>>> getLessons({
    required int unitSelectedIndex,
    required int chapterSelectedIndex,
  }) async {
    try {
      final List<Map<String, dynamic>> result =
          await lessonsRemoteDataSource.getFilteredLessons(
            unitSelectedIndex: unitSelectedIndex,
            chapterSelectedIndex: chapterSelectedIndex,
          );
      final List<LessonModel> lessons = result
          .map((json) => LessonModel.fromJson(json))
          .toList();
      return Right(lessons);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }
}
