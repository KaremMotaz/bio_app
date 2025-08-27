import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/exam_entity.dart';
import '../repos/exam_repo.dart';

class FilterPublishedResultsExams {
  final ExamRepo examRepo;

  FilterPublishedResultsExams({required this.examRepo});

  Future<Either<Failure, List<ExamEntity>>> call() async {
    final result = await examRepo.getExams();
    return result.map(
      (exams) =>
          exams.where((exam) => exam.isResultPublished).toList(),
    );
  }
}
