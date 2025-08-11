import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/server_failure.dart';
import '../../domain/chapter_repo.dart';
import '../data_source/chapters_local_data_source.dart';
import '../data_source/chapters_remote_data_source.dart';
import '../models/chapter_model.dart';

class ChapterRepoImpl implements ChapterRepo {
  final ChaptersRemoteDataSource chaptersRemoteDataSource;
  final ChaptersLocalDataSource chaptersLocalDataSource;

  ChapterRepoImpl({
    required this.chaptersRemoteDataSource,
    required this.chaptersLocalDataSource,
  });

  @override
  Future<Either<Failure, List<ChapterModel>>> getChapters({
    required String unitId,
  }) async {
    try {
      // Try to get from cache first
      final cached = await chaptersLocalDataSource.getChapters(
        unitId: unitId,
      );
      if (cached != null && cached.isNotEmpty) {
        return Right(cached);
      }

      //  No data in cache, fetch from remote
      final List<ChapterModel> chapters =
          await chaptersRemoteDataSource.getFilteredChapters(
            unitId: unitId,
          );

      // Cache the data
      await chaptersLocalDataSource.cacheChapters(
        chapters: chapters,
        unitId: unitId,
      );

      return Right(chapters);
    } catch (e, st) {
      log(e.toString(), stackTrace: st);
      return Left(ServerFailure(e.toString()));
    }
  }
}
