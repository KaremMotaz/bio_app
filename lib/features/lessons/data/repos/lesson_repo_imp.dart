import 'dart:developer';
import '../../../../core/errors/server_failure.dart';
import '../data_source/lessons_local_data_source.dart';
import '../data_source/lessons_remote_data_source.dart';
import '../models/lesson_model.dart';
import '../../domain/lesson_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';

class LessonRepoImp implements LessonRepo {
  final LessonsRemoteDataSource lessonsRemoteDataSource;
  final LessonsLocalDataSource lessonsLocalDataSource;

  LessonRepoImp({
    required this.lessonsRemoteDataSource,
    required this.lessonsLocalDataSource,
  });

  @override
  Future<Either<Failure, List<LessonModel>>> getLessons({
    required int unitId,
    required int chapterId,
  }) async {
    try {
      // Try to get from cache first
      final cached = await lessonsLocalDataSource.getLessons(
        chapterId: chapterId,
      );
      if (cached != null && cached.isNotEmpty) {
        return Right(cached);
      }

      //  No data in cache, fetch from remote
      final List<Map<String, dynamic>> result =
          await lessonsRemoteDataSource.getFilteredLessons(
            unitSelectedIndex: unitId,
            chapterSelectedIndex: chapterId,
          );
      final List<LessonModel> lessons = result
          .map((json) => LessonModel.fromJson(json))
          .toList();

      // Cache the data
      await lessonsLocalDataSource.cacheLessons(
        lessons: lessons,
        chapterId: chapterId,
      );

      return Right(lessons);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }
}
