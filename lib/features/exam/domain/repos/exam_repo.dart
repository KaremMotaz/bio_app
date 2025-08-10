import 'package:bio_app/core/errors/failure.dart';
import 'package:bio_app/features/exam/domain/entities/exam_entity.dart';
import 'package:bio_app/features/exam/domain/entities/exam_question_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ExamRepo {
  Future<Either<Failure, List<ExamEntity>>> getExams();

  Future<Either<Failure, List<ExamQuestionEntity>>> getExamQuestions({
    required String examId,
  });

  Future<void> submitAnswers({
    required String examId,
    required Map<String, dynamic> answers,
  });
}
