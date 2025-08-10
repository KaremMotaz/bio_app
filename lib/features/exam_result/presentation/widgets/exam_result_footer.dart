import 'package:bio_app/features/exam_questions/domain/entities/exam_question_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_footer_widget.dart';
import '../manager/exam_result_cubit/exam_result_cubit.dart';

class ExamResultFooter extends StatelessWidget {
  const ExamResultFooter({
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
    return BlocBuilder<ExamResultCubit, ExamResultState>(
      builder: (context, state) {
        if (state is! ExamResultLoadedState) {
          return const SizedBox();
        }

        final cubit = context.read<ExamResultCubit>();
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
          examId: '',
        );
      },
    );
  }
}
