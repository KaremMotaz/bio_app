import '../../../domain/entities/exam_entity.dart';
import 'exam_question_card.dart';
import 'package:flutter/material.dart';

class ExamPageView extends StatelessWidget {
  const ExamPageView({
    super.key,
    required this.exam,
    required this.pageController,
  });

  final ExamEntity exam;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: pageController,
        itemCount: exam.questions.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final question = exam.questions[index];
          return ExamQuestionCard(question: question);
        },
      ),
    );
  }
}
