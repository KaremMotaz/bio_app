import 'package:bio_app/features/chapters/data/repos/chapter_repo_imp.dart';
import 'package:bio_app/features/chapters/domain/chapter_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'chapter_state.dart';

class ChapterCubit extends Cubit<ChapterState> {
  ChapterCubit({required this.chapterRepoImpl})
    : super(ChapterInitialState());
  final ChapterRepoImpl chapterRepoImpl;

  Future<void> getChapters({required int selectedIndex}) async {
    emit(ChapterLoadingState());
    final result = await chapterRepoImpl.getChapters(
      selectedIndex: selectedIndex,
    );
    result.fold(
      (failure) =>
          emit(ChapterErrorState(message: failure.errMessage)),
      (chapters) => emit(ChapterLoadedState(chapters: chapters)),
    );
  }
}
