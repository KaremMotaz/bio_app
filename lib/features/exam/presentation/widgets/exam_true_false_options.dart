import '../../../../core/entities/base_question_entity.dart';

import '../../../../core/theming/option_style.dart';
import '../../../../core/widgets/true_false_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/exam_cubit/exam_cubit.dart';

class ExamTrueFalseOptions<T extends BaseQuestionEntity>
    extends StatelessWidget {
  const ExamTrueFalseOptions({
    super.key,
    required this.question,
    required this.onSelect,
  });
  final T question;
  final void Function(int index) onSelect;

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
