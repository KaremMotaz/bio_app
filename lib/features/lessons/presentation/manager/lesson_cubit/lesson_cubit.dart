import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/lesson_repo_imp.dart';
import '../../../domain/lesson_entity.dart';

part 'lesson_state.dart';

class LessonCubit extends Cubit<LessonState> {
  LessonCubit({required this.lessonRepoImp})
    : super(LessonInitialState());
  final LessonRepoImp lessonRepoImp;

  Future<void> getLessons({required int chapterId}) async {
    emit(LessonLoadingState());
    final result = await lessonRepoImp.getLessons(
      chapterId: chapterId,
    );

    result.fold(
      (failure) =>
          emit(LessonErrorState(message: failure.errMessage)),
      (lessons) => emit(LessonLoadedState(lessons: lessons)),
    );
  }
}
