import 'package:bio_app/features/exam/presentation/widgets/exam_footer.dart';
import 'package:bio_app/features/exam/presentation/widgets/exam_result_header.dart';
import 'package:bio_app/features/exam/presentation/widgets/exam_result_page_view.dart';

import '../../domain/entities/exam_entity.dart';
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
          ExamResultHeader(
            exam: widget.exam,
            pageController: _pageController,
            currentPageIndex: currentPageIndex,
          ),
          ExamResultPageView(
            exam: widget.exam,
            onPageChanged: onPageChanged,
            pageController: _pageController,
          ),
          const SizedBox(height: 12),
          ExamFooter(
            pageController: _pageController,
            exam: widget.exam,
            currentPageIndex: currentPageIndex,
            isEnabled: false,
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }
}
