import '../../../domain/repos/exam_repo.dart';
import '../../../domain/usecases/filter_published_results_exams.dart';
import '../../../domain/usecases/filter_visible_exams.dart';
import 'exams_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/failure.dart';
import '../../../domain/entities/exam_entity.dart';

class ExamsCubit extends Cubit<ExamsState> {
  final ExamRepo examRepo;
  final FilterVisibleExams filterVisibleExams;
  final FilterPublishedResultsExams filterPublishedResultsExams;

  ExamsCubit({
    required this.examRepo,
    required this.filterVisibleExams,
    required this.filterPublishedResultsExams,
  }) : super(ExamsInitialState());

  Future<void> loadExams() async {
    emit(ExamsLoadingState());

    final Either<Failure, List<ExamEntity>> availableExamsResult =
        await filterVisibleExams();

    final Either<Failure, List<ExamEntity>> pastExamsResult =
        await filterPublishedResultsExams();

    List<ExamEntity> availableExams = [];
    List<ExamEntity> pastExams = [];

    availableExamsResult.fold((failure) {
      emit(ExamsErrorState(message: failure.message));
      return;
    }, (exams) => availableExams = exams);

    pastExamsResult.fold((failure) {
      emit(ExamsErrorState(message: failure.message));
      return;
    }, (exams) => pastExams = exams);

    emit(
      ExamsLoadedState(
        availableExams: availableExams,
        pastExams: pastExams,
      ),
    );
  }

  Future<void> markExamAsOpened({required String examId}) async {
    await examRepo.markExamAsOpened(examId: examId);
  }
}
