import '../../../../core/errors/failure.dart';
import '../../../exam/domain/entities/exam_question_entity.dart';
import '../../data/models/exams_answers_model.dart';
import 'package:dartz/dartz.dart';

abstract class ExamResultRepo {
  Future<Either<Failure, List<ExamQuestionEntity>>> getExamQuestions({
    required String examId,
  });

  Future<Either<Failure, List<ExamsAnswersModel>>>
  getStudentAnswers();
}
