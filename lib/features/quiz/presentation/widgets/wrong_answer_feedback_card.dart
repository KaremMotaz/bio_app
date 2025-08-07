import '../../domain/entities/quiz_question_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../data/models/quiz_question_model.dart';
import '../../../../core/theming/feedback_messages.dart';
import '../manager/quiz_questions_cubit/quiz_questions_cubit.dart';
import 'custom_button.dart';

class WrongAnswerFeedbackCard extends StatelessWidget {
  const WrongAnswerFeedbackCard({
    super.key,
    required this.question,
    required this.isLastLifeLost,
  });

  final QuizQuestionEntity question;
  final bool isLastLifeLost;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lighterRed,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            FeedbackMessages.getRandomWrongMessage(),
            style: TextStyles.extraBold24.copyWith(
              color: AppColors.darkRed,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "الإجابة:",
            style: TextStyles.extraBold21.copyWith(
              color: AppColors.darkRed,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            question.type == QuizQuestionType.imageChoices
                ? "الإختيار رقم ${question.correctIndex + 1}"
                : question.options[question.correctIndex],
            style: TextStyles.semiBold18.copyWith(
              color: AppColors.darkRed,
            ),
          ),

          if (question.explanation != null) ...[
            const SizedBox(height: 5),
            Text(
              "السبب:",
              style: TextStyles.extraBold21.copyWith(
                color: AppColors.darkRed,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              question.explanation!,
              style: TextStyles.semiBold18.copyWith(
                color: AppColors.darkRed,
              ),
            ),
          ],
          const SizedBox(height: 25),
          CustomButton(
            text: "كمل",
            isEnabled: true,
            color: AppColors.lightRed,
            shadowColor: AppColors.darkRed,
            onPressed: () {
              final cubit = context.read<QuizQuestionsCubit>();
              if (isLastLifeLost) {
                cubit.finishQuizIfLastLifeLost();
              } else {
                cubit.nextQuestion();
              }
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
