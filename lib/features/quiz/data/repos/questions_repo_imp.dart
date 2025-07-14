import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:bio_app/core/errors/failure.dart';
import 'package:bio_app/core/errors/server_failure.dart';
import 'package:bio_app/features/quiz/data/mock_questions.dart';
import 'package:bio_app/features/quiz/data/models/question_model.dart';
import 'package:bio_app/features/quiz/domain/repos/questions_repo.dart';

class QuestionsRepoImp implements QuestionsRepo {
  @override
  Either<Failure, List<QuestionModel>> getQuestions() {
    try {
      final List<QuestionModel> questions = mockQuestions;
      return right(questions);
    } on FirebaseException catch (e) {
      return left(ServerFailure.fromFirebaseException(e));
    } on PlatformException catch (e) {
      return left(ServerFailure.fromPlatformException(e));
    } catch (e) {
      return left(ServerFailure("Unexpected error: ${e.toString()}"));
    }
  }
}
