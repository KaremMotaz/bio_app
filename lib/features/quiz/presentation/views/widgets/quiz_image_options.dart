import '../../../domain/entities/quiz_question_entity.dart';
import 'package:flutter/material.dart';
import '../../helpers/option_style.dart';
import '../../manager/quiz_cubit/quiz_cubit.dart';

class QuizImageOptions extends StatelessWidget {
  const QuizImageOptions({
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

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            backgroundColor: style.circleBackgroundColor,
            radius: 13,
            child: Text(
              "${index + 1}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 16),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                question.options[index],
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
