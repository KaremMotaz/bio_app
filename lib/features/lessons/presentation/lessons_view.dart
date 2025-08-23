import 'package:bio_app/core/widgets/custom_app_bar_pop_icon.dart';

import '../../../core/theming/app_colors.dart';
import '../../../core/theming/text_styles.dart';
import 'manager/lesson_cubit/lesson_cubit.dart';
import 'widgets/lessons_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LessonsView extends StatelessWidget {
  const LessonsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f7fc),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Navigator.of(context).canPop()
            ? const CustomAppBarPopIcon()
            : null,
        title: Text(
          "الدروس",
          style: TextStyles.bold18.copyWith(
            color: AppColors.mainBlue,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<LessonCubit, LessonState>(
          builder: (context, state) {
            switch (state) {
              case LessonLoadingState():
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.mainBlue,
                  ),
                );

              case LessonLoadedState():
                return LessonsViewBody(lessons: state.lessons);

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


