import 'package:flutter/material.dart';

import '../../domain/entities/quiz_question_entity.dart';
import '../manager/quiz_questions_cubit/quiz_questions_cubit.dart';
import 'correct_answer_feedback_card.dart';
import 'wrong_answer_feedback_card.dart';

class FeedbackCard extends StatelessWidget {
  const FeedbackCard({
    super.key,
    required this.question,
    required this.answerState,
  });

  final QuizQuestionEntity question;
  final QuizAnswerState answerState;

  @override
  Widget build(BuildContext context) {
    return answerState.isCorrect!
        ? CorrectAnswerFeedbackCard(question: question)
        : WrongAnswerFeedbackCard(
            question: question,
            isLastLifeLost: answerState.isLastLifeLost,
          );
  }
}
