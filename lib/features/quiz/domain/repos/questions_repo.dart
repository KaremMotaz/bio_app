import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../data/models/question_model.dart';

abstract class QuestionsRepo {
  Either<Failure, List<QuestionModel>> getQuestions();
}
