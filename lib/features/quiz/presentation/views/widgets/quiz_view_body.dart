import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../extensions/quiz_loaded_state_extension.dart';
import '../../manager/quiz_cubit/quiz_cubit.dart';
import 'custom_button.dart';
import 'feedback_card.dart';
import 'quiz_header.dart';
import 'quiz_page_view.dart';

class QuizViewBody extends StatelessWidget {
  const QuizViewBody({super.key, required this.state});
  final QuizLoadedState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: QuizHeader(
            progress: state.quizProgress,
            status: state.quizStatus,
          ),
        ),

        Expanded(child: QuizPageView(state: state)),

        state.isAnswered
            ? FeedbackCard(state: state)
            : Padding(
                padding: const EdgeInsets.only(
                  right: 16,
                  left: 16,
                  bottom: 16,
                ),
                child: CustomButton(
                  isEnabled: state.isSelected,
                  onPressed: () {
                    context.read<QuizCubit>().checkAnswer();
                  },
                ),
              ),
      ],
    );
  }
}
