import 'package:bio_app/core/errors/failure.dart';
import 'package:bio_app/features/exam/data/repos/exam_repo_impl.dart';
import 'package:bio_app/features/exam/domain/entities/exam_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'exams_state.dart';

class ExamsCubit extends Cubit<ExamsState> {
  final ExamRepoImpl examRepoImpl;

  ExamsCubit({required this.examRepoImpl})
    : super(ExamsInitialState());

  void getExams() async {
    emit(ExamsLoadingState());

    final Either<Failure, List<ExamEntity>> exams = await examRepoImpl
        .getExams();

    exams.fold(
      (failure) => emit(ExamsErrorState(message: failure.errMessage)),
      (exams) => emit(ExamsLoadedState(exams)),
    );
  }
}
