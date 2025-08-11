import 'package:bio_app/features/exam/domain/entities/exam_question_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_footer_widget.dart';
import '../manager/exam_questions_cubit/exam_questions_cubit.dart';

class ExamQuestionsFooter extends StatelessWidget {
  const ExamQuestionsFooter({
    super.key,
    required PageController pageController,
    required this.currentPageIndex,
    this.isEnabled,
    required this.examQuestions,
    required this.examId,
  }) : _pageController = pageController;

  final PageController _pageController;
  final List<ExamQuestionEntity> examQuestions;
  final int currentPageIndex;
  final bool? isEnabled;
  final String examId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamQuestionsCubit, ExamQuestionsState>(
      builder: (context, state) {
        if (state is! ExamQuestionsRunningState) {
          return const SizedBox();
        }

        final cubit = context.read<ExamQuestionsCubit>();
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
          examId: examId,
        );
      },
    );
  }
}
