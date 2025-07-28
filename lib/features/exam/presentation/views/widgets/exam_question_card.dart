import 'package:flutter/material.dart';

import '../../../../../core/theming/text_styles.dart';
import '../../../domain/entities/exam_question_entity.dart';
import 'exam_question_options.dart';

class ExamQuestionCard extends StatelessWidget {
  final ExamQuestionEntity question;

  const ExamQuestionCard({
    super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            SizedBox(height: 20),

            Column(
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
            ),

            SizedBox(height: 10),

            if (question.images != null) ...[
              const SizedBox(height: 20),
              ...List.generate(question.images!.length, (
                index,
              ) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      question.images![index],
                      height: 230,
                      width: 300,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              }),
            ],
            ExamQuestionOptions(question: question),
          ],
        ),
      ),
    );
  }
}
