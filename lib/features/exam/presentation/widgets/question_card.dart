import 'question_images.dart';
import 'question_widget.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/exam_question_entity.dart';
import 'question_options.dart';

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
            const SizedBox(height: 20),
            QuestionWidget(question: question),
            const SizedBox(height: 10),
            QuestionImages(question: question),
            const SizedBox(height: 20),
            QuestionOptions(question: question),
          ],
        ),
      ),
    );
  }
}
