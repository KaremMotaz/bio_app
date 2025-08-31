import 'package:bio_app/core/widgets/close_icon.dart';
import 'package:bio_app/core/widgets/exam_question_numbers_grid_view.dart';
import 'package:flutter/material.dart';

import '../../features/exam/domain/entities/exam_question_entity.dart';
import '../theming/text_styles.dart';

class SelectorWidget extends StatelessWidget {
  const SelectorWidget({
    super.key,
    required this.currentPageIndex,
    required this.pageController,
    this.answers,
    required this.examQuestions,
  });

  final List<ExamQuestionEntity> examQuestions;
  final int currentPageIndex;
  final PageController pageController;
  final Map<String, dynamic>? answers;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      titlePadding: const EdgeInsets.only(
        top: 4,
        left: 16,
        right: 24,
      ),
      title: const Padding(
        padding: EdgeInsets.only(bottom: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CloseIcon(),
            Text('اختر رقم السؤال', style: TextStyles.semiBold18),
          ],
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: ExamQuestionNumbersGridView(
          examQuestions: examQuestions,
          currentPageIndex: currentPageIndex,
          answers: answers,
          pageController: pageController,
        ),
      ),
    );
  }
}
