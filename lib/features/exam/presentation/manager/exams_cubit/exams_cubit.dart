import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failure.dart';
import '../../../domain/entities/exam_entity.dart';
import '../../../domain/repos/exam_repo.dart';
import '../../../domain/usecases/filter_published_results_exams.dart';
import '../../../domain/usecases/filter_visible_exams.dart';
import 'exams_state.dart';

class ExamsCubit extends Cubit<ExamsState> {
  final ExamRepo examRepo;
  final FilterVisibleExams filterVisibleExams;
  final FilterPublishedResultsExams filterPublishedResultsExams;

  ExamsCubit({
    required this.examRepo,
    required this.filterVisibleExams,
    required this.filterPublishedResultsExams,
  }) : super(ExamsLoadingState());

  Future<void> loadExams() async {
    if (isClosed) return;
    emit(ExamsLoadingState());

    final Either<Failure, List<ExamEntity>> availableExamsResult =
        await filterVisibleExams();

    final Either<Failure, List<ExamEntity>> pastExamsResult =
        await filterPublishedResultsExams();

    // if (availableExamsResult.isRight() && pastExamsResult.isRight()) {
    //   await Future.delayed(const Duration(seconds: 1));
    //   return loadExams();
    // }

    List<ExamEntity> availableExams = [];
    List<ExamEntity> pastExams = [];

    // availableExamsResult.fold((failure) {
    //   if (isClosed) return;
    //   emit(ExamsErrorState(message: failure.message));
    //   return;
    // }, (exams) => availableExams = exams);

    availableExamsResult.fold((failure) => null, (exams) {

      if (exams.isEmpty) {
        log(exams.toString());
        Future.delayed(const Duration(seconds: 1), loadExams);
      }else {
        availableExams = exams;
      }
    });

    pastExamsResult.fold((failure) {
      if (isClosed) return;
      emit(ExamsErrorState(message: failure.message));
      return;
    }, (exams) => pastExams = exams);

    if (isClosed) return;
    emit(
      ExamsLoadedState(
        availableExams: availableExams,
        pastExams: pastExams,
      ),
    );
  }
}
