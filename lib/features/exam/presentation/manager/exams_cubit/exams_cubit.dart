import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failure.dart';
import '../../../data/repos/exam_repo_impl.dart';
import '../../../domain/entities/exam_entity.dart';

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
