import 'dart:developer';
import 'package:bio_app/core/errors/server_failure.dart';
import 'package:bio_app/features/chapters/data/data_source/chapters_remote_data_source.dart';
import 'package:bio_app/features/chapters/data/models/chapter_model.dart';
import 'package:bio_app/features/chapters/domain/chapter_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:bio_app/core/errors/failure.dart';

class ChapterRepoImpl implements ChapterRepo {
  ChaptersRemoteDataSource chaptersRemoteDataSource;
  ChapterRepoImpl({required this.chaptersRemoteDataSource});

  @override
  Future<Either<Failure, List<ChapterModel>>> getChapters({
    required int selectedIndex,
  }) async {
    try {
      final List<Map<String, dynamic>> result =
          await chaptersRemoteDataSource.getFilteredChapters(
            selectedIndex: selectedIndex,
          );

      final List<ChapterModel> chapters = result
          .map((json) => ChapterModel.fromJson(json))
          .toList();
      return Right(chapters);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }
}
