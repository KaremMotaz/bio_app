import 'package:bio_app/core/errors/failure.dart';
import 'package:bio_app/features/exam_questions/domain/entities/exam_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ExamRepo {
  Future<Either<Failure, List<ExamEntity>>> getExams();
}
