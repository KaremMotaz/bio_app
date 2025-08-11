import '../../../../core/errors/failure.dart';
import '../entities/exam_question_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ExamQuestionsRepo {
  
  Future<Either<Failure, List<ExamQuestionEntity>>> getExamQuestions({
    required String examId,
  });

  Future<void> submitAnswers({
    required String examId,
    required Map<String, int> answers,
  });
}
