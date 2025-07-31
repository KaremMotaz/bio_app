import 'package:bio_app/core/widgets/true_false_options.dart';
import 'package:bio_app/features/exam_result/presentation/manager/exam_result_cubit/exam_result_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/entities/exam_question_entity.dart';

class ExamResultTrueFalseOptions extends StatelessWidget {
  const ExamResultTrueFalseOptions({
    super.key,
    required this.question,
    this.isEnabled,
  });

  final ExamQuestionEntity question;
  final bool? isEnabled;

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
          selectedIndex: selectedIndex,
          isEnabled: isEnabled ?? true,
          onSelect: (index) {},
        );
      },
    );
  }
}
