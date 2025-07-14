import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bio_app/features/quiz/presentation/extensions/quiz_loaded_state_extension.dart';
import 'package:bio_app/features/quiz/presentation/manager/quiz_cubit/quiz_cubit.dart';
import 'package:bio_app/features/quiz/presentation/views/widgets/custom_button.dart';
import 'package:bio_app/features/quiz/presentation/views/widgets/feedback_card.dart';
import 'package:bio_app/features/quiz/presentation/views/widgets/quiz_header.dart';
import 'package:bio_app/features/quiz/presentation/views/widgets/quiz_page_view.dart';

class QuizViewBody extends StatelessWidget {
  const QuizViewBody({super.key, required this.state});
  final QuizLoadedState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: QuizHeader(
            progress: state.quizProgress,
            status: state.quizStatus,
          ),
        ),

        Expanded(child: QuizPageView(state: state)),

        state.isAnswered
            ? FeedbackCard(state: state)
            : Padding(
                padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
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
