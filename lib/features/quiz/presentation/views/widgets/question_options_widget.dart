import 'package:flutter/material.dart';

import '../../../data/models/quiz_question_model.dart';
import '../../manager/quiz_cubit/quiz_cubit.dart';
import 'image_options_widget.dart';
import 'text_options_widget.dart';
import 'true_false_0ptions_widget.dart';

class QuestionOptionsWidget extends StatelessWidget {
  const QuestionOptionsWidget({
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
        return TextOptionsWidget(
          questionModel: question,
          index: index,
          answerState: answerState,
        );
      case QuizQuestionType.imageChoices:
        return ImageOptionsWidget(
          questionModel: question,
          index: index,
          answerState: answerState,
        );
      case QuizQuestionType.trueFalse:
        return TrueFalseOptionsWidget(
          questionModel: question,
          index: index,
          answerState: answerState,
        );
    }
  }
}
