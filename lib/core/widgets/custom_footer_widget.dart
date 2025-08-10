import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/exam_questions/presentation/manager/exam_questions_cubit/exam_questions_cubit.dart';
import 'app_text_button.dart';

class CustomFooterWidget<T extends Cubit> extends StatelessWidget {
  const CustomFooterWidget({
    super.key,
    required this.isFirstPage,
    required PageController pageController,
    required this.currentPageIndex,
    required this.isLastPage,
    required this.isEnabled,
    required this.cubit,
    required this.examId,
  }) : _pageController = pageController;

  final bool isFirstPage;
  final PageController _pageController;
  final int currentPageIndex;
  final bool isLastPage;
  final bool? isEnabled;
  final String examId;
  final T cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!isFirstPage) ...[
            Expanded(
              child: AppTextButton(
                buttonText: "السابق",
                onPressed: () {
                  _pageController.animateToPage(
                    currentPageIndex - 1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
            const SizedBox(width: 100),
          ],
          Expanded(
            child: AppTextButton(
              buttonText: isLastPage ? "إنهاء الاختبار" : "التالي",
              onPressed: () {
                if (isLastPage) {
                  if (isEnabled ?? true) {
                    if (cubit is ExamQuestionsCubit) {
                      (cubit as ExamQuestionsCubit).submitExam(
                        examId: examId,
                      );
                    }
                  } else {
                    GoRouter.of(context).pop(context);
                  }
                } else {
                  _pageController.animateToPage(
                    currentPageIndex + 1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
