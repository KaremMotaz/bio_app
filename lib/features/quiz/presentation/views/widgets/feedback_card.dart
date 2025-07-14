import 'package:flutter/material.dart';
import 'package:bio_app/features/quiz/presentation/extensions/quiz_loaded_state_extension.dart';
import 'package:bio_app/features/quiz/presentation/manager/quiz_cubit/quiz_cubit.dart';
import 'package:bio_app/features/quiz/presentation/views/widgets/correct_answer_feedback_card.dart';
import 'package:bio_app/features/quiz/presentation/views/widgets/wrong_answer_feedback_card.dart';

class FeedbackCard extends StatelessWidget {
  const FeedbackCard({super.key, required this.state});

  final QuizLoadedState state;

  @override
  Widget build(BuildContext context) {
    return state.isCorrectAnswered
        ? CorrectAnswerFeedbackCard(state: state)
        : WrongAnswerFeedbackCard(state: state);
  }
}
