import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/features/quiz/presentation/extensions/quiz_loaded_state_extension.dart';
import 'package:bio_app/features/quiz/presentation/manager/quiz_cubit/quiz_cubit.dart';
import 'package:bio_app/features/quiz/presentation/views/widgets/custom_button.dart';
import 'package:bio_app/features/quiz/presentation/helpers/feedback_messages.dart';

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
          SizedBox(height: 8),
          if (state.explanation != null) ...[
            Text(
              state.explanation!,
              style: TextStyles.semiBold18.copyWith(color: AppColors.darkGreen),
            ),
          ],
          SizedBox(height: 25),
          CustomButton(
            text: "كمل",
            isEnabled: true,
            onPressed: () {
              context.read<QuizCubit>().nextQuestion();
            },
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
