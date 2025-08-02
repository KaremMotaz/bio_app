import 'exam_question_result_options.dart';
import 'result_feedback_card.dart';
import '../../../exam/domain/entities/exam_question_entity.dart';
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
            QuestionWidget<ExamQuestionEntity>(question: question),
            const SizedBox(height: 10),
            QuestionImages<ExamQuestionEntity>(question: question),
            const SizedBox(height: 20),
            ExamQuestionResultOptions<ExamQuestionEntity>(
              question: question,
              onSelect: (int index) {},
            ),
            const SizedBox(height: 20),
            ResultFeedbackCard<ExamQuestionEntity>(
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
