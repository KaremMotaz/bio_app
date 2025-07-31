import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/entities/exam_question_entity.dart';
import '../manager/exam_cubit/exam_cubit.dart';

class ExamMcqOptions extends StatelessWidget {
  const ExamMcqOptions({
    super.key,
    required this.question,
    this.isEnabled = true,
  });

  final ExamQuestionEntity question;
  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(question.options.length, (
        index,
      ) {
        return BlocSelector<ExamCubit, ExamState, bool>(
          selector: (state) {
            if (state is ExamRunningState) {
              return state.answers[question.id
                      .toString()] ==
                  index;
            }
            return false;
          },
          builder: (context, isSelected) {
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
                child: Text(
                  question.options[index],
                  style: TextStyles.semiBold18.copyWith(
                    color: isSelected && isEnabled! 
                        ? AppColors.darkBlue
                        : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
