import '../../../../core/widgets/custom_footer_widget.dart';
import '../../../exam/domain/entities/exam_entity.dart';
import '../manager/exam_result_cubit/exam_result_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamResultFooter extends StatelessWidget {
  const ExamResultFooter({
    super.key,
    required PageController pageController,
    required this.exam,
    required this.currentPageIndex,
    this.isEnabled,
  }) : _pageController = pageController;

  final PageController _pageController;
  final ExamEntity exam;
  final int currentPageIndex;
  final bool? isEnabled;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamResultCubit, ExamResultState>(
      builder: (context, state) {
        if (state is! ExamResultLoadedState) {
          return const SizedBox();
        }

        final cubit = context.read<ExamResultCubit>();
        final isLastPage =
            currentPageIndex == exam.questions.length - 1;
        final isFirstPage = currentPageIndex == 0;

        return CustomFooterWidget(
          isFirstPage: isFirstPage,
          pageController: _pageController,
          currentPageIndex: currentPageIndex,
          isLastPage: isLastPage,
          isEnabled: isEnabled,
          cubit: cubit,
        );
      },
    );
  }
}
