import '../../../core/errors/failure.dart';
import '../data/models/lesson_model.dart';
import 'package:dartz/dartz.dart';

abstract class LessonRepo {
  Future<Either<Failure, List<LessonModel>>> getLessons({
    required int unitId,
    required int chapterId,
  });
}
