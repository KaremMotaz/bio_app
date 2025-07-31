import '../../../../core/entities/exam_question_entity.dart';
import '../../../exam/presentation/widgets/question_images.dart';
import '../../../exam/presentation/widgets/question_options.dart';
import '../../../exam/presentation/widgets/question_widget.dart';
import 'package:flutter/material.dart';

class ExamResultDetailsQuestionCard extends StatelessWidget {
  const ExamResultDetailsQuestionCard({
    super.key,
    required this.question,
  });
  final ExamQuestionEntity question;

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
            QuestionOptions(question: question, isEnabled: false),
            const SizedBox(height: 20),
            // FeedbackCard(state: question),
          ],
        ),
      ),
    );
  }
}
