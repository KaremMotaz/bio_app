import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/features/chapters/presentation/manager/chapter_cubit/chapter_cubit.dart';
import 'package:bio_app/features/chapters/presentation/widgets/chapter_view_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ChapterView extends StatelessWidget {
  const ChapterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ChapterCubit, ChapterState>(
          builder: (context, state) {
            switch (state) {
              case ChapterLoadingState():
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.mainBlue,
                  ),
                );

              case ChapterLoadedState():
                return ChapterViewBody(chapters: state.chapters);

              case ChapterErrorState(:final message):
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
