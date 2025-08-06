import 'package:bio_app/core/errors/failure.dart';
import 'package:bio_app/features/chapters/data/models/chapter_model.dart';
import 'package:dartz/dartz.dart';

abstract class ChapterRepo {
  Future<Either<Failure, List<ChapterModel>>> getChapters({
    required int unitId,
  });
}
