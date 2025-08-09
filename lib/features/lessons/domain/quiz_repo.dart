import '../../../core/errors/failure.dart';
import '../data/models/quiz_model.dart';
import 'package:dartz/dartz.dart';

abstract class QuizRepo {
  Future<Either<Failure, List<QuizModel>>> getQuizzes({
    required String lessonId,
  });
}
