part of 'chapter_cubit.dart';

@immutable
sealed class ChapterState {}

final class ChapterInitialState extends ChapterState {}

final class ChapterLoadingState extends ChapterState {}

final class ChapterLoadedState extends ChapterState {
  final List<ChapterEntity> chapters;
  ChapterLoadedState({required this.chapters});
}

final class ChapterErrorState extends ChapterState {
  final String message;
  ChapterErrorState({required this.message});
}
