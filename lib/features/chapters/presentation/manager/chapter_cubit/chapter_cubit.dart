import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/chapter_repo_imp.dart';
import '../../../domain/chapter_entity.dart';

part 'chapter_state.dart';

class ChapterCubit extends Cubit<ChapterState> {
  ChapterCubit({required this.chapterRepoImpl})
    : super(ChapterInitialState());
  final ChapterRepoImpl chapterRepoImpl;

  Future<void> getChapters({required String unitId}) async {
    emit(ChapterLoadingState());
    final result = await chapterRepoImpl.getChapters(unitId: unitId);
    result.fold(
      (failure) => emit(ChapterErrorState(message: failure.message)),
      (chapters) => emit(ChapterLoadedState(chapters: chapters)),
    );
  }
}
