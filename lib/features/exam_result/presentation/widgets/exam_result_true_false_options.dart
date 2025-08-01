import '../../../../core/entities/base_question_entity.dart';
import '../../../../core/theming/option_style.dart';
import '../../../../core/widgets/true_false_options.dart';
import '../manager/exam_result_cubit/exam_result_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamResultTrueFalseOptions<T extends BaseQuestionEntity>
    extends StatelessWidget {
  const ExamResultTrueFalseOptions({
    super.key,
    required this.question,
    this.isEnabled,
    required this.onSelect,
  });

  final T question;
  final bool? isEnabled;
  final void Function(int) onSelect;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamResultCubit, ExamResultState>(
      builder: (context, state) {
        int? selectedIndex;
        if (state is ExamResultLoadedState) {
          selectedIndex = state.answers[question.id.toString()];
        }
        return TrueFalseOptions(
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
