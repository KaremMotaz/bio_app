import '../../../../core/entities/base_question_entity.dart';

import '../../../../core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class QuestionWidget<T extends BaseQuestionEntity>
    extends StatelessWidget {
  const QuestionWidget({super.key, required this.question});

  final T question;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (question.scenario != null) ...[
          Text(
            "${question.id + 1}- ${question.scenario}",
            style: TextStyles.bold17,
          ),
          const SizedBox(height: 5),
          Text(
            "- ${question.questionText}",
            style: TextStyles.bold17,
          ),
        ] else ...[
          Text(
            "${question.id + 1}- ${question.questionText}",
            style: TextStyles.bold17,
          ),
        ],
      ],
    );
  }
}
