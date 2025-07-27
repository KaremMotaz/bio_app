import 'package:bio_app/core/widgets/app_text_button.dart';
import 'package:bio_app/features/exam/domain/entities/exam_entity.dart';
import 'package:bio_app/features/exam/presentation/manager/exam_cubit/exam_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamFooter extends StatelessWidget {
  const ExamFooter({
    super.key,
    required PageController pageController,
    required this.exam,
  }) : _pageController = pageController;

  final PageController _pageController;
  final ExamEntity exam;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamCubit, ExamState>(
      builder: (context, state) {
        final cubit = context.read<ExamCubit>();
        final isLastPage =
            cubit.currentPageIndex ==
            exam.questions.length - 1;
        final isFirstPage = cubit.currentPageIndex == 0;

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              if (!isFirstPage) ...[
                Expanded(
                  child: AppTextButton(
                    buttonText: "السابق",
                    onPressed: () {
                      cubit.goToPreviousPage();
                      _pageController.animateToPage(
                        cubit.currentPageIndex,
                        duration: const Duration(
                          milliseconds: 300,
                        ),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 100),
              ],

              Expanded(
                child: AppTextButton(
                  buttonText: isLastPage
                      ? "إنهاء الاختبار"
                      : "التالي",
                  onPressed: () {
                    if (isLastPage) {
                  
                      cubit.submitExam();
                    } else {
                      cubit.goToNextPage();
                      _pageController.animateToPage(
                        cubit.currentPageIndex,
                        duration: const Duration(
                          milliseconds: 300,
                        ),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
