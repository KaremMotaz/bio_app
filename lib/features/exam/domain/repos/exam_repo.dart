import '../../../../core/errors/failure.dart';
import '../entities/exam_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ExamRepo {
  Future<Either<Failure, List<ExamEntity>>> getExams();
}
