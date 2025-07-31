import 'package:bio_app/core/widgets/image_options.dart';
import 'package:bio_app/features/exam_result/presentation/manager/exam_result_cubit/exam_result_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/entities/exam_question_entity.dart';

class ExamResultImagesOptions extends StatelessWidget {
  const ExamResultImagesOptions({
    super.key,
    required this.question,
    this.isEnabled,
  });

  final ExamQuestionEntity question;
  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamResultCubit, ExamResultState>(
      buildWhen: (previous, current) =>
          current is ExamResultLoadedState,
      builder: (context, state) {
        if (state is! ExamResultLoadedState) return const SizedBox();
        final selectedIndex = state.answers[question.id.toString()];
        final canSelect = isEnabled ?? true;

        return ImageOptions(
          options: question.options,
          selectedIndex: selectedIndex,
          isEnabled: canSelect,
          onSelect: (index) {},
        );
      },
    );
  }
}
