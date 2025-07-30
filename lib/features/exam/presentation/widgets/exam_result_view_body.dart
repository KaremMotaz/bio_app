import '../../domain/entities/exam_entity.dart';
import 'exam_result_question_card.dart';
import 'package:flutter/material.dart';

class ExamResultViewBody extends StatefulWidget {
  const ExamResultViewBody({super.key, required this.exam});
  final ExamEntity exam;

  @override
  State<ExamResultViewBody> createState() =>
      _ExamResultViewBodyState();
}

class _ExamResultViewBodyState
    extends State<ExamResultViewBody> {
  final PageController _pageController = PageController();
  int currentPageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.exam.questions.length,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      itemBuilder: (context, index) {
        final question = widget.exam.questions[index];
        return ExamResultQuestionCard(question: question);
      },
    );
  }
}
