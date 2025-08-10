import 'package:flutter/material.dart';

import '../../../exam_questions/domain/entities/exam_question_entity.dart';
import '../../../exam_questions/presentation/widgets/question_images.dart';
import '../../../exam_questions/presentation/widgets/question_widget.dart';
import 'exam_question_result_options.dart';
import 'result_feedback_card.dart';

class ExamResultDetailsQuestionCard extends StatelessWidget {
  const ExamResultDetailsQuestionCard({
    super.key,
    required this.question,
    required this.isCorrect,
    required this.answers,
  });
  final ExamQuestionEntity question;
  final bool isCorrect;
  final Map<String, int> answers;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 20),
            QuestionWidget<ExamQuestionEntity>(question: question),
            const SizedBox(height: 10),
            QuestionImages<ExamQuestionEntity>(question: question),
            const SizedBox(height: 20),
            ExamQuestionResultOptions(
              question: question,
              onSelect: (int index) {},
              answers: answers,
            ),
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
