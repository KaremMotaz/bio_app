import 'package:bio_app/core/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theming/app_colors.dart';
import '../../../core/widgets/custom_app_bar_pop_icon.dart';
import '../../chapters/domain/chapter_entity.dart';
import 'manager/lesson_cubit/lesson_cubit.dart';
import 'widgets/lessons_view_body.dart';

class LessonsView extends StatelessWidget {
  const LessonsView({super.key, required this.chapter});
  final ChapterEntity chapter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f7fc),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: Navigator.of(context).canPop()
            ? const CustomAppBarPopIcon()
            : null,
        title: Text(chapter.title),
      ),
      body: SafeArea(
        child: BlocBuilder<LessonCubit, LessonState>(
          builder: (context, state) {
            switch (state) {
              case LessonLoadingState():
                return const CustomCircularProgressIndicator(
                  color: AppColors.mainBlue,
                );

              case LessonLoadedState():
                return LessonsViewBody(
                  lessons: state.lessons,
                  chapterImage: chapter.image,
                );

              case LessonErrorState(:final message):
                return Center(child: Text(message));

              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
