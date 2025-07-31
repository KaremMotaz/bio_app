import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/features/exam/domain/entities/exam_entity.dart';
import 'package:bio_app/features/exam/presentation/widgets/select_exam_question.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          const Text(
            "النتيجة",
            style: TextStyles.semiBold16,
          ),
          SelectExamQuestion(
            exam: exam,
            pageController: pageController,
            currentPageIndex: currentPageIndex,
          ),
        ],
      ),
    );
  }
}
