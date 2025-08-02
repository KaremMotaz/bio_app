import '../../../../core/entities/base_question_entity.dart';

import '../../../../core/theming/option_style.dart';
import '../../../../core/widgets/image_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/exam_cubit/exam_cubit.dart';

class ExamImagesOptions<T extends BaseQuestionEntity>
    extends StatelessWidget {
  const ExamImagesOptions({
    super.key,
    required this.question,
    required this.onSelect,
  });

  final T question;
  final void Function(int index) onSelect;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamCubit, ExamState>(
      buildWhen: (previous, current) => current is ExamRunningState,
      builder: (context, state) {
        if (state is! ExamRunningState) return const SizedBox();

        final selectedIndex = state.answers[question.id.toString()];

        return ImageOptions(
          options: question.options,
          onSelect: onSelect,
          styleBuilder: (int index) {
            return OptionStyle.examQuestionStyle(
              isSelected: selectedIndex == index,
            );
          },
        );
      },
    );
  }
}
