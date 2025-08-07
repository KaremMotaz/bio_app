import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../data/models/chapter_model.dart';

abstract class ChapterRepo {
  Future<Either<Failure, List<ChapterModel>>> getChapters({
    required int unitId,
  });
}
