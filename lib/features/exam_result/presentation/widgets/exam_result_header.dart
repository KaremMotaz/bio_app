import 'package:bio_app/features/exam/domain/entities/exam_question_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';
import 'select_exam_result_question.dart';

class ExamResultHeader extends StatelessWidget {
  const ExamResultHeader({
    super.key,
    required this.pageController,
    required this.examQuestions,
    required this.currentPageIndex,
  });
  final PageController pageController;
  final List<ExamQuestionEntity> examQuestions;
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
            examQuestions: examQuestions,
            pageController: pageController,
            currentPageIndex: currentPageIndex,
          ),
        ],
      ),
    );
  }
}
