import '../../../../../core/widgets/app_text_button.dart';
import '../../../domain/entities/exam_entity.dart';
import '../../manager/exam_cubit/exam_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamFooter extends StatelessWidget {
  const ExamFooter({
    super.key,
    required PageController pageController,
    required this.exam,
    required this.currentPageIndex,
  }) : _pageController = pageController;

  final PageController _pageController;
  final ExamEntity exam;
  final int currentPageIndex;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamCubit, ExamState>(
      builder: (context, state) {
        if (state is! ExamRunningState) {
          return const SizedBox();
        }

        final cubit = context.read<ExamCubit>();
        final isLastPage =
            currentPageIndex == exam.questions.length - 1;
        final isFirstPage = currentPageIndex == 0;

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
                      _pageController.animateToPage(
                        currentPageIndex - 1,
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
                      _pageController.animateToPage(
                        currentPageIndex + 1,
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
