import 'package:flutter/material.dart';

import '../../features/exam/domain/entities/exam_entity.dart';
import '../theming/app_colors.dart';
import '../theming/text_styles.dart';

class SelectorWidget extends StatelessWidget {
  const SelectorWidget({
    super.key,
    required this.exam,
    required this.currentPageIndex,
    required this.pageController,
    this.answers,
  });

  final ExamEntity exam;
  final int currentPageIndex;
  final PageController pageController;
  final Map<String, dynamic>? answers;

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
            final bool isCurrent = index == currentPageIndex;
            final String questionId = exam.questions[index].index.toString();
            final bool isAnswered = answers?.containsKey(questionId) ?? false;

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
