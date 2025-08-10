import 'package:flutter/material.dart';
import '../../domain/entities/exam_question_entity.dart';
import 'exam_question_card.dart';

class ExamPageView extends StatelessWidget {
  const ExamPageView({
    super.key,
    required this.pageController,
    required this.onPageChanged,
    required this.answers,
    required this.questions,
  });

  final List<ExamQuestionEntity> questions;
  final PageController pageController;
  final Function(int) onPageChanged;
  final Map<String, int> answers;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: pageController,
        itemCount: questions.length,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
        itemBuilder: (context, index) {
          return ExamQuestionCard(
            question: questions[index],
            answers: answers,
          );
        },
      ),
    );
  }
}
