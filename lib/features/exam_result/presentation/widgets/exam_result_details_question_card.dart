import 'package:bio_app/features/exam_result/presentation/widgets/question_result_options.dart';
import 'package:bio_app/features/exam_result/presentation/widgets/result_feedback_card.dart';

import '../../../../core/entities/exam_question_entity.dart';
import '../../../exam/presentation/widgets/question_images.dart';
import '../../../exam/presentation/widgets/question_widget.dart';
import 'package:flutter/material.dart';

class ExamResultDetailsQuestionCard extends StatelessWidget {
  const ExamResultDetailsQuestionCard({
    super.key,
    required this.question,
    required this.isCorrect,
  });
  final ExamQuestionEntity question;
  final bool isCorrect;

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
            QuestionResultOptions(question: question),
            const SizedBox(height: 20),
            ResultFeedbackCard(
              isCorrect: isCorrect,
              question: question,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
