import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/server_failure.dart';
import '../../domain/repos/questions_repo.dart';
import '../mock_quiz_questions.dart';
import '../models/quiz_question_model.dart';

class QuestionsRepoImp implements QuestionsRepo {
  @override
  Either<Failure, List<QuizQuestionModel>> getQuestions() {
    try {
      final List<QuizQuestionModel> questions =
        mockQuizQuestions;
      return right(questions);
    } on FirebaseException catch (e) {
      return left(ServerFailure.fromFirebaseException(e));
    } on PlatformException catch (e) {
      return left(ServerFailure.fromPlatformException(e));
    } catch (e) {
      return left(
        ServerFailure("Unexpected error: ${e.toString()}"),
      );
    }
  }
}
