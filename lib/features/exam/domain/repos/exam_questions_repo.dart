import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/exam_question_entity.dart';

abstract class ExamQuestionsRepo {
  
  Future<Either<Failure, List<ExamQuestionEntity>>> getExamQuestions({
    required String examId,
  });

  Future<void> submitAnswers({
    required String examId,
    required Map<String, int> answers,
  });
}
