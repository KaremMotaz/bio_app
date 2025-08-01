import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../exam/domain/entities/exam_entity.dart';
import 'select_exam_result_question.dart';

class ExamResultHeader extends StatelessWidget {
  const ExamResultHeader({
    super.key,
    required this.pageController,
    required this.exam,
    required this.currentPageIndex,
  });
  final PageController pageController;
  final ExamEntity exam;
  final int currentPageIndex;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.mainBlue,
            ),
          ),
          const Text("النتيجة", style: TextStyles.semiBold16),
          SelectExamResultQuestion(
            exam: exam,
            pageController: pageController,
            currentPageIndex: currentPageIndex,
          ),
        ],
      ),
    );
  }
}
