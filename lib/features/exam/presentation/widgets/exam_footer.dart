import 'package:bio_app/features/exam/domain/entities/exam_question_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_footer_widget.dart';
import '../manager/exam_cubit/exam_cubit.dart';

class ExamFooter extends StatelessWidget {
  const ExamFooter({
    super.key,
    required PageController pageController,
    required this.currentPageIndex,
    this.isEnabled,
    required this.examQuestions,
  }) : _pageController = pageController;

  final PageController _pageController;
  final List<ExamQuestionEntity> examQuestions;
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
            currentPageIndex == examQuestions.length - 1;
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
