import 'package:flutter/material.dart';

import '../../domain/entities/exam_entity.dart';
import 'exam_footer.dart';
import 'exam_header.dart';
import 'exam_page_view.dart';

class ExamViewBody extends StatefulWidget {
  const ExamViewBody({
    super.key,
    required this.exam,
    required this.answers,
  });

  final ExamEntity exam;
  final Map<String, int> answers;

  @override
  State<ExamViewBody> createState() => _ExamViewBodyState();
}

class _ExamViewBodyState extends State<ExamViewBody> {
  final PageController _pageController = PageController();
  int currentPageIndex = 0;

  void onPageChanged(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          ExamHeader(
            exam: widget.exam,
            pageController: _pageController,
            currentPageIndex: currentPageIndex,
          ),
          ExamPageView(
            exam: widget.exam,
            pageController: _pageController,
            onPageChanged: onPageChanged,
            answers: widget.answers,
          ),
          const SizedBox(height: 12),
          ExamFooter(
            pageController: _pageController,
            exam: widget.exam,
            currentPageIndex: currentPageIndex,
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }
}
