import 'package:flutter/material.dart';

import '../../domain/entities/exam_entity.dart';
import '../../domain/entities/exam_question_entity.dart';
import 'exam_question_card.dart';

class ExamPageView extends StatelessWidget {
  const ExamPageView({
    super.key,
    required this.exam,
    required this.pageController,
    required this.onPageChanged,
    required this.answers,
  });

  final ExamEntity exam;
  final PageController pageController;
  final Function(int) onPageChanged;
  final Map<String, int> answers;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: pageController,
        itemCount: exam.questions.length,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
        itemBuilder: (context, index) {
          final ExamQuestionEntity question = exam.questions[index];
          return ExamQuestionCard(
            question: question,
            answers: answers,
          );
        },
      ),
    );
  }
}
