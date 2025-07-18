import 'package:flutter/material.dart';

import '../../extensions/quiz_loaded_state_extension.dart';
import '../../manager/quiz_cubit/quiz_cubit.dart';
import 'correct_answer_feedback_card.dart';
import 'wrong_answer_feedback_card.dart';

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
