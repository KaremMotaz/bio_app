import 'package:bio_app/features/exam_result/presentation/views/widgets/exam_result_question_card.dart';
import 'package:flutter/material.dart';

class ExamResultViewBody extends StatefulWidget {
  const ExamResultViewBody({super.key});

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
      itemCount: 1,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      itemBuilder: (context, index) {
        // final question = exam.questions[index];
        return ExamResultQuestionCard();
      },
    );
  }
}
