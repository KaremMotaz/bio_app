import 'package:bio_app/features/exam/presentation/widgets/exam_footer.dart';
import 'package:bio_app/features/exam_result/presentation/widgets/exam_result_header.dart';
import 'package:bio_app/features/exam_result/presentation/widgets/exam_result_details_page_view.dart';

import '../../../exam/domain/entities/exam_entity.dart';
import 'package:flutter/material.dart';

class ExamResultDetailsViewBody extends StatefulWidget {
  const ExamResultDetailsViewBody({super.key, required this.exam});
  final ExamEntity exam;

  @override
  State<ExamResultDetailsViewBody> createState() =>
      _ExamResultDetailsViewBodyState();
}

class _ExamResultDetailsViewBodyState
    extends State<ExamResultDetailsViewBody> {
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
          ExamResultDetailsPageView(
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
