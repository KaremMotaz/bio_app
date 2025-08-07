import 'package:flutter/material.dart';

import '../../../../core/entities/base_question_entity.dart';
import 'correct_answer_card.dart';
import 'wrong_answer_card.dart';

class ResultFeedbackCard<T extends BaseQuestionEntity>
    extends StatelessWidget {
  const ResultFeedbackCard({
    super.key,
    required this.isCorrect,
    required this.question,
  });
  final bool isCorrect;
  final T question;

  @override
  Widget build(BuildContext context) {
    return isCorrect
        ? CorrectAnswerCard(question: question)
        : WrongAnswerCard(question: question);
  }
}
