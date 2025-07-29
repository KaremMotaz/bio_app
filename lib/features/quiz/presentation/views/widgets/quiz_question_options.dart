import '../../../domain/entities/quiz_question_entity.dart';
import 'package:flutter/material.dart';

import '../../../data/models/quiz_question_model.dart';
import '../../manager/quiz_cubit/quiz_cubit.dart';
import 'quiz_image_options.dart';
import 'quiz_text_options.dart';
import 'quiz_true_false_0ptions.dart';

class QuizQuestionOptions extends StatelessWidget {
  const QuizQuestionOptions({
    super.key,
    required this.question,
    required this.index,
    required this.answerState,
  });
  final QuizQuestionEntity question;
  final QuizAnswerState answerState;
  final int index;

  @override
  Widget build(BuildContext context) {
    switch (question.type) {
      case QuizQuestionType.textChoices:
        return QuizTextOptions(
          question: question,
          index: index,
          answerState: answerState,
        );
      case QuizQuestionType.imageChoices:
        return QuizImageOptions(
          question: question,
          index: index,
          answerState: answerState,
        );
      case QuizQuestionType.trueFalse:
        return QuizTrueFalseOptions(
          question: question,
          index: index,
          answerState: answerState,
        );
    }
  }
}
