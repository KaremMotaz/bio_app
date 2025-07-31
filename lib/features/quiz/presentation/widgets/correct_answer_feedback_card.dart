import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../extensions/quiz_loaded_state_extension.dart';
import '../helpers/feedback_messages.dart';
import '../manager/quiz_cubit/quiz_cubit.dart';
import 'custom_button.dart';

class CorrectAnswerFeedbackCard extends StatelessWidget {
  const CorrectAnswerFeedbackCard({super.key, required this.state});
  final QuizLoadedState state;

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
            style: TextStyles.extraBold24.copyWith(color: AppColors.darkGreen),
          ),
          const SizedBox(height: 8),
          if (state.explanation != null) ...[
            Text(
              state.explanation!,
              style: TextStyles.semiBold18.copyWith(color: AppColors.darkGreen),
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
