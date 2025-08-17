import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/lesson_repo_imp.dart';
import '../../../domain/lesson_entity.dart';

part 'lesson_state.dart';

class LessonCubit extends Cubit<LessonState> {
  LessonCubit({required this.lessonRepoImp})
    : super(LessonInitialState());
  final LessonRepoImp lessonRepoImp;

  Future<void> getLessons({
    required String chapterId,
    required String unitId,
  }) async {
    emit(LessonLoadingState());
    final result = await lessonRepoImp.getLessons(
      chapterId: chapterId,
      unitId: unitId,
    );

    result.fold(
      (failure) => emit(LessonErrorState(message: failure.message)),
      (lessons) => emit(LessonLoadedState(lessons: lessons)),
    );
  }
}
