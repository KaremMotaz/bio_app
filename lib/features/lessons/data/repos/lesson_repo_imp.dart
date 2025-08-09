import 'dart:developer';
import '../data_source/lessons_local_data_source.dart';

import '../../../../core/errors/server_failure.dart';
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
    required String chapterId,
    required String unitId,
  }) async {
    try {
      // Try to get from cache first
      final cached = await lessonsLocalDataSource.getLessons(
        chapterId: chapterId,
        unitId: unitId,
      );
      if (cached != null && cached.isNotEmpty) {
        return Right(cached);
      }

      //  No data in cache, fetch from remote
      final List<LessonModel> lessons = await lessonsRemoteDataSource
          .getFilteredLessons(chapterId: chapterId, unitId: unitId);

      // Cache the data
      await lessonsLocalDataSource.cacheLessons(
        lessons: lessons,
        chapterId: chapterId,
        unitId: unitId,
      );

      return Right(lessons);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }
}
