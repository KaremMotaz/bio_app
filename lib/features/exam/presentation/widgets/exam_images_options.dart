import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theming/app_colors.dart';
import '../../domain/entities/exam_question_entity.dart';
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
      buildWhen: (previous, current) =>
          current is ExamRunningState,
      builder: (context, state) {
        if (state is! ExamRunningState) {
          return const SizedBox();
        }

        final selectedIndex =
            state.answers[question.id.toString()];

        return Column(
          children: List.generate(question.options.length, (
            index,
          ) {
            final isSelected = selectedIndex == index;

            return GestureDetector(
              onTap: () {
                if (isEnabled ?? true) {
                  context.read<ExamCubit>().selectAnswer(
                    question.id,
                    index,
                  );
                }
              },
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: isSelected && isEnabled! 
                        ? AppColors.lightBlue
                        : Colors.grey.shade300,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: isSelected && isEnabled! 
                          ? AppColors.lightBlue
                          : Colors.white,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    question.options[index],
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
