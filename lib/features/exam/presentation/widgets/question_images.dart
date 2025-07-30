import 'package:flutter/material.dart';

import '../../domain/entities/exam_question_entity.dart';

class QuestionImages extends StatelessWidget {
  const QuestionImages({super.key, required this.question});
  final ExamQuestionEntity question;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (question.images != null) ...[
          const SizedBox(height: 20),
          ...List.generate(question.images!.length, (
            index,
          ) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                question.images![index],
                height: 230,
                width: 300,
                fit: BoxFit.fill,
              ),
            );
          }),
        ],
      ],
    );
  }
}
