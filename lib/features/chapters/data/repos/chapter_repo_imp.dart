import 'dart:developer';
import 'package:bio_app/core/errors/server_failure.dart';
import 'package:bio_app/core/errors/failure.dart';
import 'package:bio_app/features/chapters/data/data_source/chapters_remote_data_source.dart';
import 'package:bio_app/features/chapters/data/data_source/chapters_local_data_source.dart'; // <-- by unit
import 'package:bio_app/features/chapters/data/models/chapter_model.dart';
import 'package:bio_app/features/chapters/domain/chapter_repo.dart';
import 'package:dartz/dartz.dart';

class ChapterRepoImpl implements ChapterRepo {
  final ChaptersRemoteDataSource chaptersRemoteDataSource;
  final ChaptersLocalDataSource chaptersLocalDataSource;

  ChapterRepoImpl({
    required this.chaptersRemoteDataSource,
    required this.chaptersLocalDataSource,
  });

  @override
  Future<Either<Failure, List<ChapterModel>>> getChapters({
    required int unitId,
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
      final List<Map<String, dynamic>> result =
          await chaptersRemoteDataSource.getFilteredChapters(
            unitId: unitId,
          );

      final chapters = result
          .map((json) => ChapterModel.fromJson(json))
          .toList();

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
