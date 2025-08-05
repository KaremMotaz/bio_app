import 'package:bio_app/core/errors/failure.dart';
import 'package:bio_app/features/lessons/data/models/lesson_model.dart';
import 'package:dartz/dartz.dart';

abstract class LessonRepo {
  Future<Either<Failure, List<LessonModel>>> getLessons({
    required int unitSelectedIndex,
    required int chapterSelectedIndex,
  });
}
