import 'package:bio_app/core/errors/failure.dart';
import 'package:bio_app/features/lessons/data/models/quiz_model.dart';
import 'package:dartz/dartz.dart';

abstract class QuizRepo {
  Future<Either<Failure, List<QuizModel>>> getQuizzes({
    required int lessonId,
  });
}
