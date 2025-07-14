import 'package:flutter/material.dart';
import 'package:bio_app/features/quiz/presentation/helpers/option_style.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/features/quiz/data/models/question_model.dart';
import 'package:bio_app/features/quiz/presentation/manager/quiz_cubit/quiz_cubit.dart';

class TrueFalseOptionsWidget extends StatelessWidget {
  const TrueFalseOptionsWidget({
    super.key,
    required this.questionModel,
    required this.index,
    required this.answerState,
  });

  final QuestionModel questionModel;
  final int index;
  final QuizAnswerState answerState;

  @override
  Widget build(BuildContext context) {
    final OptionStyle style = OptionStyle(answerState: answerState);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: style.borderColor, width: 2),
        boxShadow: [
          BoxShadow(color: style.shadowColor, offset: const Offset(0, 3)),
        ],
      ),
      child: Text(
        questionModel.options[index],
        textAlign: TextAlign.center,
        style: TextStyles.semiBold18.copyWith(color: style.fontColor),
      ),
    );
  }
}
