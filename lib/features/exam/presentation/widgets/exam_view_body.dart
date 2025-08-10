import 'package:bio_app/features/exam/domain/entities/exam_question_entity.dart';
import 'package:flutter/material.dart';
import 'exam_footer.dart';
import 'exam_header.dart';
import 'exam_page_view.dart';

class ExamViewBody extends StatefulWidget {
  const ExamViewBody({
    super.key,
    required this.examQuestions,
    required this.answers,
  });

  final List<ExamQuestionEntity> examQuestions;
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
            examQuestions: widget.examQuestions,
            pageController: _pageController,
            currentPageIndex: currentPageIndex,
          ),
          ExamPageView(
            pageController: _pageController,
            onPageChanged: onPageChanged,
            answers: widget.answers,
            questions: widget.examQuestions,
          ),
          const SizedBox(height: 12),
          ExamFooter(
            pageController: _pageController,
            examQuestions: widget.examQuestions,
            currentPageIndex: currentPageIndex,
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }
}
