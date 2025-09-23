import '../theming/app_colors.dart';
import '../../features/exam/domain/entities/exam_question_entity.dart';
import 'package:flutter/material.dart';

class ExamQuestionNumbersGridView extends StatelessWidget {
  const ExamQuestionNumbersGridView({
    super.key,
    required this.examQuestions,
    required this.currentPageIndex,
    required this.answers,
    required this.pageController,
  });

  final List<ExamQuestionEntity> examQuestions;
  final int currentPageIndex;
  final Map<String, dynamic>? answers;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: examQuestions.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final bool isCurrent = index == currentPageIndex;
        final String questionId = examQuestions[index].index
            .toString();
        final bool isAnswered =
            answers?.containsKey(questionId) ?? false;

        Color bgColor;
        if (isCurrent) {
          bgColor = AppColors.mainBlue;
        } else if (isAnswered) {
          bgColor = AppColors.green;
        } else {
          bgColor = AppColors.grey300;
        }

        return GestureDetector(
          onTap: () {
            Navigator.pop(context);
            pageController.jumpToPage(index);
          },
          child: Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              '${index + 1}',
              style: TextStyle(
                color: isCurrent ? AppColors.white : AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
