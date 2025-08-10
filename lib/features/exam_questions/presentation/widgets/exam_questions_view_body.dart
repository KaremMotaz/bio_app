import 'package:bio_app/features/exam_questions/domain/entities/exam_question_entity.dart';
import 'package:flutter/material.dart';
import 'exam_questions_footer.dart';
import 'exam_questions_header.dart';
import 'exam_questions_page_view.dart';

class ExamQuestionsViewBody extends StatefulWidget {
  const ExamQuestionsViewBody({
    super.key,
    required this.examQuestions,
    required this.answers,
    required this.examId,
  });

  final List<ExamQuestionEntity> examQuestions;
  final Map<String, int> answers;
  final String examId;

  @override
  State<ExamQuestionsViewBody> createState() =>
      _ExamQuestionsViewBodyState();
}

class _ExamQuestionsViewBodyState
    extends State<ExamQuestionsViewBody> {
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
          ExamQuestionsHeader(
            examQuestions: widget.examQuestions,
            pageController: _pageController,
            currentPageIndex: currentPageIndex,
          ),
          ExamQuestionsPageView(
            pageController: _pageController,
            onPageChanged: onPageChanged,
            answers: widget.answers,
            questions: widget.examQuestions,
          ),
          const SizedBox(height: 12),
          ExamQuestionsFooter(
            pageController: _pageController,
            examQuestions: widget.examQuestions,
            currentPageIndex: currentPageIndex,
            examId: widget.examId,
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }
}
