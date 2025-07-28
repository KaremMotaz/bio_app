import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/features/exam/domain/entities/exam_entity.dart';
import 'package:bio_app/features/exam/presentation/manager/exam_cubit/exam_cubit.dart';
import 'package:flutter/material.dart';

class SelectExamQuestion extends StatelessWidget {
  const SelectExamQuestion({
    super.key,
    required this.exam,
    required this.cubit,
    required this.pageController,
  });

  final ExamEntity exam;
  final ExamCubit cubit;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
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
                    final isCurrent =
                        index == cubit.currentPageIndex;
                    final isAnswered = cubit.answers
                        .containsKey(index.toString());

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
                        cubit.jumpToQuestion(
                          index: index,
                          pageController: pageController,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius:
                              BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: isCurrent
                                ? Colors.white
                                : Colors.black,
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
          },
        );
      },
      icon: Icon(
        Icons.apps_rounded,
        color: AppColors.mainBlue,
        size: 28,
      ),
    );
  }
}
