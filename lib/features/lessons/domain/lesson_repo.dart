import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../data/models/lesson_model.dart';

abstract class LessonRepo {
  Future<Either<Failure, List<LessonModel>>> getLessons({
    required String chapterId,
    required String unitId,
  });
}
