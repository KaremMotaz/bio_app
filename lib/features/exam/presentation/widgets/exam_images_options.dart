import 'package:bio_app/core/theming/option_style.dart';
import 'package:bio_app/core/widgets/image_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/entities/exam_question_entity.dart';
import '../manager/exam_cubit/exam_cubit.dart';

class ExamImagesOptions extends StatelessWidget {
  const ExamImagesOptions({
    super.key,
    required this.question,
    this.isEnabled,
  });

  final ExamQuestionEntity question;
  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamCubit, ExamState>(
      buildWhen: (previous, current) => current is ExamRunningState,
      builder: (context, state) {
        if (state is! ExamRunningState) return const SizedBox();

        final selectedIndex = state.answers[question.id.toString()];
        final canSelect = isEnabled ?? true;

        return ImageOptions(
          options: question.options,
          selectedIndex: selectedIndex,
          isEnabled: canSelect,
          onSelect: (index) {
            context.read<ExamCubit>().selectAnswer(
              question.id,
              index,
            );
          },
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
