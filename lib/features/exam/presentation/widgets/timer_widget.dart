import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../manager/exam_cubit/exam_cubit.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamCubit, ExamState>(
      buildWhen: (previous, current) =>
          current is ExamRunningState,
      builder: (context, state) {
        if (state is! ExamRunningState) {
          return const SizedBox.shrink();
        }

        final minutes = (state.remainingTimeInSeconds ~/ 60)
            .toString()
            .padLeft(2, '0');
        final seconds = (state.remainingTimeInSeconds % 60)
            .toString()
            .padLeft(2, '0');

        return Text(
          '$minutes:$seconds',
          style: TextStyles.semiBold18.copyWith(
            color: AppColors.darkBlue,
            fontFeatures: const [
              FontFeature.tabularFigures(),
            ],
          ),
        );
      },
    );
  }
}
