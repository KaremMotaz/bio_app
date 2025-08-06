import '../../../core/theming/app_colors.dart';
import '../../../core/theming/text_styles.dart';
import 'manager/chapter_cubit/chapter_cubit.dart';
import 'widgets/chapter_view_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ChapterView extends StatelessWidget {
  const ChapterView({super.key, required this.unitId});
  final int unitId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "الفصول",
          style: TextStyles.bold18.copyWith(
            color: AppColors.mainBlue,
          ),
        ),
      ),
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
                return ChapterViewBody(
                  chapters: state.chapters,
                  unitId: unitId,
                );

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
