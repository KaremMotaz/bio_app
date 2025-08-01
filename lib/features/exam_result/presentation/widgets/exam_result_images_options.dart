import '../../../../core/entities/base_question_entity.dart';

import '../../../../core/theming/option_style.dart';
import '../../../../core/widgets/image_options.dart';
import '../manager/exam_result_cubit/exam_result_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamResultImagesOptions<T extends BaseQuestionEntity>
    extends StatelessWidget {
  const ExamResultImagesOptions({
    super.key,
    required this.question,
    required this.onSelect,
  });

  final T question;
  final void Function(int) onSelect;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamResultCubit, ExamResultState>(
      buildWhen: (previous, current) =>
          current is ExamResultLoadedState,
      builder: (context, state) {
        if (state is! ExamResultLoadedState) return const SizedBox();
        final selectedIndex = state.answers[question.id.toString()];

        return ImageOptions(
          options: question.options,
          onSelect: onSelect,
          styleBuilder: (int index) {
            return OptionStyle.examResultQuestionStyle(
              isSelected: selectedIndex == index,
              isCorrect: question.correctIndex == index,
            );
          },
        );
      },
    );
  }
}
