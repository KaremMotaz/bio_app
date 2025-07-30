import 'package:bio_app/features/exam/domain/entities/exam_entity.dart';
import 'package:bio_app/features/exam/domain/entities/exam_question_entity.dart';
import 'package:bio_app/features/exam/presentation/widgets/exam_result_question_card.dart';
import 'package:flutter/material.dart';

class ExamResultPageView extends StatelessWidget {
  const ExamResultPageView({
    super.key,
    required this.exam,
    required this.pageController,
    required this.onPageChanged,
  });
  final ExamEntity exam;
  final PageController pageController;
  final Function(int) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: pageController,
        itemCount: exam.questions.length,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
        itemBuilder: (context, index) {
          final ExamQuestionEntity question =
              exam.questions[index];
          return ExamResultQuestionCard(question: question);
        },
      ),
    );
  }
}
