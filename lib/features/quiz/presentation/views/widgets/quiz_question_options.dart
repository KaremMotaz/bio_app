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
  final QuizQuestionModel question;
  final QuizAnswerState answerState;
  final int index;

  @override
  Widget build(BuildContext context) {
    switch (question.type) {
      case QuizQuestionType.textChoices:
        return QuizTextOptions(
          questionModel: question,
          index: index,
          answerState: answerState,
        );
      case QuizQuestionType.imageChoices:
        return QuizImageOptions(
          questionModel: question,
          index: index,
          answerState: answerState,
        );
      case QuizQuestionType.trueFalse:
        return QuizTrueFalseOptions(
          questionModel: question,
          index: index,
          answerState: answerState,
        );
    }
  }
}
