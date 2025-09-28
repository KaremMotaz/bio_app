import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
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
    } on FirebaseException catch (e) {
      return Left(ServerFailure.fromFirebaseException(e));
    } on PlatformException catch (e) {
      return Left(ServerFailure.fromPlatformException(e));
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure.unknown(e.toString()));
    }
  }
}
