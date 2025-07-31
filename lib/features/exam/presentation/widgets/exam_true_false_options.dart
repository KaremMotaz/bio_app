import 'package:bio_app/core/theming/option_style.dart';
import 'package:bio_app/core/widgets/true_false_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/entities/exam_question_entity.dart';
import '../manager/exam_cubit/exam_cubit.dart';

class ExamTrueFalseOptions extends StatelessWidget {
  const ExamTrueFalseOptions({
    super.key,
    required this.question,
    this.isEnabled,
  });

  final ExamQuestionEntity question;
  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamCubit, ExamState>(
      builder: (context, state) {
        int? selectedIndex;
        if (state is ExamRunningState) {
          selectedIndex = state.answers[question.id.toString()];
        }

        return TrueFalseOptions(
          options: question.options,
          selectedIndex: selectedIndex,
          isEnabled: isEnabled ?? true,
          onSelect: (index) {
            if (isEnabled ?? true) {
              context.read<ExamCubit>().selectAnswer(
                question.id,
                index,
              );
            }
          },
          styleBuilder: (int index) {
            return OptionStyle.examQuestionStyle(
              isSelected: selectedIndex == index,
              isEnabled: isEnabled!,
            );
          },
        );
      },
    );
  }
}
