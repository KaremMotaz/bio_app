import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/quiz_question_model.dart';

abstract class QuestionsRepo {
  Either<Failure, List<QuizQuestionModel>> getQuestions();
}
