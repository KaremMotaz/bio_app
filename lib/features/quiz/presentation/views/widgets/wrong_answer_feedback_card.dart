import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../data/models/question_model.dart';
import '../../extensions/quiz_loaded_state_extension.dart';
import '../../helpers/feedback_messages.dart';
import '../../manager/quiz_cubit/quiz_cubit.dart';
import 'custom_button.dart';

class WrongAnswerFeedbackCard extends StatelessWidget {
  const WrongAnswerFeedbackCard({super.key, required this.state});
  final QuizLoadedState state;

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
            style: TextStyles.extraBold24.copyWith(color: AppColors.darkRed),
          ),
          SizedBox(height: 8),
          Text(
            "الإجابة:",
            style: TextStyles.extraBold21.copyWith(color: AppColors.darkRed),
          ),
          SizedBox(height: 8),
          Text(
            state.currentQuestion.questionType == QuestionType.imageChoices
                ? "الإختيار رقم ${state.correctImageAnswerNumber}"
                : state.correctAnswerText,
            style: TextStyles.semiBold18.copyWith(color: AppColors.darkRed),
          ),

          if (state.explanation != null) ...[
            SizedBox(height: 5),
            Text(
              "السبب:",
              style: TextStyles.extraBold21.copyWith(color: AppColors.darkRed),
            ),
            SizedBox(height: 5),
            Text(
              state.explanation!,
              style: TextStyles.semiBold18.copyWith(color: AppColors.darkRed),
            ),
          ],
          SizedBox(height: 25),
          CustomButton(
            text: "كمل",
            isEnabled: true,
            color: AppColors.lightRed,
            shadowColor: AppColors.darkRed,
            onPressed: () {
              final cubit = context.read<QuizCubit>();
              if (state.isLastLifeLost) {
                cubit.finishQuizIfLastLifeLost();
              } else {
                cubit.nextQuestion();
              }
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
