import 'dart:developer';

import 'package:bio_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:bio_app/features/exam/data/repos/exam_repo_impl.dart';
import 'package:bio_app/features/exam/domain/entities/exam_entity.dart';

class FilterVisibleExams {
  final ExamRepoImpl examRepoImpl;

  FilterVisibleExams({required this.examRepoImpl});

  Future<Either<Failure, List<ExamEntity>>> call() async {
    final examsResult = await examRepoImpl.getExams();
    final openedExamsResult = await examRepoImpl
        .getOpenedExamsStatus();

    return examsResult.fold((failure) => left(failure), (exams) {
      return openedExamsResult.fold((failure) => left(failure), (
        openedExams,
      ) {
        final List<ExamEntity> filteredExams = exams.where((exam) {
          final isOpened = openedExams[exam.id] ?? false;
          log("shouldShowExam: ${shouldShowExam(exam, isOpened)}");
          for (var exam in exams) {
            final isOpened = openedExams[exam.id] ?? false;
            log(
              "Exam: ${exam.title}, published: ${exam.isPublished}, start: ${exam.startTime}, end: ${exam.endTime}, openedByStudent: $isOpened",
            );
            log("shouldShowExam: ${shouldShowExam(exam, isOpened)}");
          }
          return shouldShowExam(exam, isOpened);
        }).toList();
        return right(filteredExams);
      });
    });
  }

  bool shouldShowExam(ExamEntity exam, bool isOpenedByStudent) {
    final now = DateTime.now();
    final hasStarted = now.isAfter(exam.startTime);
    final hasEnded = now.isAfter(exam.endTime);

    if (exam.isPublished && !hasEnded) {
      if (!hasStarted) return true;
      if (hasStarted && !isOpenedByStudent) return true;
    }
    return false;
  }
}
