import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/widgets/selector_widget.dart';
import '../../domain/entities/exam_entity.dart';
import '../manager/exam_cubit/exam_cubit.dart';

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

                  return SelectorWidget(
                    exam: exam,
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
