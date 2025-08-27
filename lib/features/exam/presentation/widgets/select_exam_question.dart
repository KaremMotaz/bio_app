import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/widgets/selector_widget.dart';
import '../../domain/entities/exam_question_entity.dart';
import '../manager/exam_questions_cubit/exam_questions_cubit.dart';

class SelectExamQuestion extends StatelessWidget {
  const SelectExamQuestion({
    super.key,
    required this.pageController,
    required this.currentPageIndex,
    required this.examQuestions,
  });

  final List<ExamQuestionEntity> examQuestions;
  final PageController pageController;
  final int currentPageIndex;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final examCubit = context.read<ExamQuestionsCubit>();

        showDialog(
          context: context,
          builder: (dialogContext) {
            return BlocProvider.value(
              value: examCubit,
              child:
                  BlocBuilder<ExamQuestionsCubit, ExamQuestionsState>(
                    builder: (context, state) {
                      if (state is! ExamQuestionsRunningState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return SelectorWidget(
                        examQuestions: examQuestions,
                        currentPageIndex: currentPageIndex,
                        pageController: pageController,
                        answers: state.answers,
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
