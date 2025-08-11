import 'package:bio_app/core/errors/failure.dart';
import 'package:bio_app/features/exam/domain/entities/exam_question_entity.dart';
import 'package:bio_app/features/exam_result/data/models/exams_answers_model.dart';
import 'package:dartz/dartz.dart';

abstract class ExamResultRepo {
  Future<Either<Failure, List<ExamQuestionEntity>>> getExamQuestions({
    required String examId,
  });

  Future<Either<Failure, List<ExamsAnswersModel>>>
  getStudentAnswers();
}
