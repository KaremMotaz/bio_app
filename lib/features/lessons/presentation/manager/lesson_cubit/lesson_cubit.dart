import 'package:bio_app/features/lessons/data/repos/lesson_repo_imp.dart';
import 'package:bio_app/features/lessons/domain/lesson_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'lesson_state.dart';

class LessonCubit extends Cubit<LessonState> {
  LessonCubit({required this.lessonRepoImp})
    : super(LessonInitialState());
  final LessonRepoImp lessonRepoImp;

  Future<void> getLessons() async {
    emit(LessonLoadingState());
    final result = await lessonRepoImp.getLessons();
    result.fold(
      (failure) =>
          emit(LessonErrorState(message: failure.errMessage)),
      (lessons) => emit(LessonLoadedState(lessons: lessons)),
    );
  }
}
