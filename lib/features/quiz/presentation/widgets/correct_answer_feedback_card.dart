import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/feedback_messages.dart';
import '../../../../core/theming/text_styles.dart';
import '../../domain/entities/quiz_question_entity.dart';
import '../manager/quiz_cubit/quiz_cubit.dart';
import 'custom_button.dart';

class CorrectAnswerFeedbackCard extends StatelessWidget {
  const CorrectAnswerFeedbackCard({
    super.key,
    required this.question,
  });
  final QuizQuestionEntity question;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lighterGreen,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            FeedbackMessages.getRandomCorrectMessage(),
            style: TextStyles.extraBold24.copyWith(
              color: AppColors.darkGreen,
            ),
          ),
          const SizedBox(height: 8),
          if (question.explanation != null) ...[
            Text(
              question.explanation!,
              style: TextStyles.semiBold18.copyWith(
                color: AppColors.darkGreen,
              ),
            ),
          ],
          const SizedBox(height: 25),
          CustomButton(
            text: "كمل",
            isEnabled: true,
            onPressed: () {
              context.read<QuizCubit>().nextQuestion();
            },
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
