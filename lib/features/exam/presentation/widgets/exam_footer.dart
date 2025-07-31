import 'package:bio_app/core/widgets/custom_footer_widget.dart';
import '../../domain/entities/exam_entity.dart';
import '../manager/exam_cubit/exam_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamFooter extends StatelessWidget {
  const ExamFooter({
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
    return BlocBuilder<ExamCubit, ExamState>(
      builder: (context, state) {
        if (state is! ExamRunningState) {
          return const SizedBox();
        }

        final cubit = context.read<ExamCubit>();
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
