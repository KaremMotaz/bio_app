import 'package:bio_app/core/errors/failure.dart';
import 'package:bio_app/features/exam_questions/domain/entities/exam_entity.dart';
import 'package:bio_app/features/exam_questions/domain/entities/exam_question_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ExamResultRepo {
  Future<Either<Failure, List<ExamEntity>>> getExams();

  Future<Either<Failure, List<ExamQuestionEntity>>> getExamQuestions({
    required String examId,
  });

  Future<Either<Failure, List<Map<String, int>>>> getStudentAnswers();
}
