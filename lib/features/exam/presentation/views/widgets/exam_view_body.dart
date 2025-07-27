import '../../../domain/entities/exam_entity.dart';
import 'exam_footer.dart';
import 'exam_header.dart';
import 'exam_page_view.dart';
import 'timer_widget.dart';
import 'package:flutter/material.dart';

class ExamViewBody extends StatefulWidget {
  const ExamViewBody({super.key, required this.exam});

  final ExamEntity exam;

  @override
  State<ExamViewBody> createState() => _ExamViewBodyState();
}

class _ExamViewBodyState extends State<ExamViewBody> {
  final PageController _pageController = PageController();

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
          ExamHeader(),
          TimerWidget(duration: widget.exam.duration),
          ExamPageView(
            exam: widget.exam,
            pageController: _pageController,
          ),
          SizedBox(height: 12),
          ExamFooter(
            pageController: _pageController,
            exam: widget.exam,
          ),
          SizedBox(height: 18),
        ],
      ),
    );
  }
}
