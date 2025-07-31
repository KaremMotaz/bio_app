import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../domain/entities/exam_entity.dart';
import '../manager/exam_cubit/exam_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectExamQuestion extends StatelessWidget {
  const SelectExamQuestion({
    super.key,
    required this.exam,
    required this.pageController,
    required this.currentPageIndex,
  });

  final ExamEntity exam;
  final PageController pageController;
  final int currentPageIndex;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final examCubit = context.read<ExamCubit>();

        showDialog(
          context: context,
          builder: (dialogContext) {
            return BlocProvider.value(
              value: examCubit,
              child: BlocBuilder<ExamCubit, ExamState>(
                builder: (context, state) {
                  if (state is! ExamRunningState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

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
                              index == currentPageIndex;
                          final questionId = exam
                              .questions[index]
                              .id
                              .toString();
                          final isAnswered = state.answers
                              .containsKey(questionId);

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
                              pageController.jumpToPage(
                                index,
                              ); 
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius:
                                    BorderRadius.circular(
                                      8,
                                    ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color: isCurrent
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(context),
                        child: const Text('إغلاق'),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        );
      },
      icon: const Icon(
        Icons.apps_rounded,
        color: AppColors.mainBlue,
        size: 28,
      ),
    );
  }
}
