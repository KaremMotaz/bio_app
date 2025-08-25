import 'package:bio_app/features/units/domain/unit_entity.dart';

import '../../../core/widgets/custom_app_bar_pop_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theming/app_colors.dart';
import 'manager/chapter_cubit/chapter_cubit.dart';
import 'widgets/chapter_view_body.dart';

class ChapterView extends StatelessWidget {
  const ChapterView({super.key, required this.unit});
  final UnitEntity unit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.of(context).canPop()
            ? const CustomAppBarPopIcon()
            : null,
        title: Text(unit.title),
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
                  unitId: unit.id,
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
