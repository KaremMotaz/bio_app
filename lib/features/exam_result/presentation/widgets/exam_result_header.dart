import '../../../../core/widgets/custom_app_bar_pop_icon.dart';
import 'package:flutter/material.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../exam/domain/entities/exam_question_entity.dart';
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
          const CustomAppBarPopIcon(),
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
