import 'package:dartz/dartz.dart';
import 'package:bio_app/core/errors/failure.dart';
import 'package:bio_app/features/quiz/data/models/question_model.dart';

abstract class QuestionsRepo {
  Either<Failure, List<QuestionModel>> getQuestions();
}
