import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/server_failure.dart';
import '../../domain/repos/questions_repo.dart';
import '../mock_questions.dart';
import '../models/question_model.dart';

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
