import 'package:bio_app/features/exam/domain/entities/exam.dart';
import 'package:bio_app/features/exam/presentation/views/widgets/exam_footer.dart';
import 'package:bio_app/features/exam/presentation/views/widgets/exam_header.dart';
import 'package:bio_app/features/exam/presentation/views/widgets/exam_page_view.dart';
import 'package:bio_app/features/exam/presentation/views/widgets/timer_widget.dart';
import 'package:flutter/material.dart';

class ExamViewBody extends StatefulWidget {
  const ExamViewBody({super.key, required this.exam});

  final Exam exam;

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
