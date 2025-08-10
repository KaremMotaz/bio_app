import 'package:bio_app/features/exam/domain/entities/exam_question_entity.dart';
import 'package:flutter/material.dart';
import 'exam_result_details_page_view.dart';
import 'exam_result_footer.dart';
import 'exam_result_header.dart';

class ExamResultDetailsViewBody extends StatefulWidget {
  const ExamResultDetailsViewBody({
    super.key,
    required this.answers,
    required this.examQuestions,
  });
  final List<ExamQuestionEntity> examQuestions;
  final Map<String, int> answers;

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
            examQuestions: widget.examQuestions,
            pageController: _pageController,
            currentPageIndex: currentPageIndex,
          ),
          ExamResultDetailsPageView(
            examQuestions: widget.examQuestions,
            onPageChanged: onPageChanged,
            pageController: _pageController,
            answers: widget.answers,
          ),
          const SizedBox(height: 12),
          ExamResultFooter(
            pageController: _pageController,
            examQuestions: widget.examQuestions,
            currentPageIndex: currentPageIndex,
            isEnabled: false,
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }
}
