import 'package:flutter/material.dart';

import '../../../../core/theming/text_styles.dart';
import '../../domain/entities/quiz_question_entity.dart';
import '../helpers/option_style.dart';
import '../manager/quiz_cubit/quiz_cubit.dart';

class QuizTrueFalseOptions extends StatelessWidget {
  const QuizTrueFalseOptions({
    super.key,
    required this.question,
    required this.index,
    required this.answerState,
  });

  final QuizQuestionEntity question;
  final int index;
  final QuizAnswerState answerState;

  @override
  Widget build(BuildContext context) {
    final OptionStyle style = OptionStyle(
      answerState: answerState,
    );

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 16,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: style.borderColor,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: style.shadowColor,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        question.options[index],
        textAlign: TextAlign.center,
        style: TextStyles.semiBold18.copyWith(
          color: style.fontColor,
        ),
      ),
    );
  }
}
