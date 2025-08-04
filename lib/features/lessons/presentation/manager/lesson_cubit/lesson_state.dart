part of 'lesson_cubit.dart';

@immutable
sealed class LessonState {}

final class LessonInitialState extends LessonState {}

final class LessonLoadingState extends LessonState {}

final class LessonLoadedState extends LessonState {
  final List<LessonEntity> lessons;
  LessonLoadedState({required this.lessons});
}

final class LessonErrorState extends LessonState {
  final String message;
  LessonErrorState({required this.message});
}
