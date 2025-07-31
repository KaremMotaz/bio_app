import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/features/exam/domain/entities/exam_entity.dart';
import 'package:flutter/material.dart';

class SelectorWidget extends StatelessWidget {
  const SelectorWidget({
    super.key,
    required this.exam,
    required this.currentPageIndex,
    required this.pageController,
    required this.answers,
  });

  final ExamEntity exam;
  final int currentPageIndex;
  final PageController pageController;
  final Map<String, dynamic> answers;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text(
        'اختر رقم السؤال',
        style: TextStyles.semiBold15,
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: exam.questions.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
          itemBuilder: (context, index) {
            final isCurrent = index == currentPageIndex;
            final questionId = exam.questions[index].id.toString();
            final isAnswered = answers.containsKey(questionId);

            Color bgColor;
            if (isCurrent) {
              bgColor = AppColors.mainBlue;
            } else if (isAnswered) {
              bgColor = Colors.green;
            } else {
              bgColor = Colors.grey[300]!;
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
                    color: isCurrent ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إغلاق'),
        ),
      ],
    );
  }
}
