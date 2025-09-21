import 'package:bio_app/core/theming/app_colors.dart';
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
    return Dialog(
      backgroundColor: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CloseIcon(),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'اختر رقم السؤال',
                    style: TextStyles.semiBold18,
                  ),
                  const SizedBox(height: 20),
                  ExamQuestionNumbersGridView(
                    examQuestions: examQuestions,
                    currentPageIndex: currentPageIndex,
                    answers: answers,
                    pageController: pageController,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
