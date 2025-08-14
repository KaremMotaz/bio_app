import '../../../exam/domain/entities/exam_question_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/widgets/selector_widget.dart';
import '../manager/exam_result_cubit/exam_result_cubit.dart';

class SelectExamResultQuestion extends StatelessWidget {
  const SelectExamResultQuestion({
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
        final examCubit = context.read<ExamResultCubit>();

        showDialog(
          context: context,
          builder: (dialogContext) {
            return BlocProvider.value(
              value: examCubit,
              child: BlocBuilder<ExamResultCubit, ExamResultState>(
                builder: (context, state) {
                  if (state is! ExamResultLoadedState) {
                    return const SizedBox.shrink();
                  }
                  return SelectorWidget(
                    examQuestions: examQuestions,
                    currentPageIndex: currentPageIndex,
                    pageController: pageController,
                    answers: const {},
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
