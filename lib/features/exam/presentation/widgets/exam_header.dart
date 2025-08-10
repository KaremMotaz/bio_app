import 'package:bio_app/features/exam/domain/entities/exam_question_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theming/text_styles.dart';
import '../manager/exam_cubit/exam_cubit.dart';
import 'select_exam_question.dart';
import 'timer_widget.dart';

class ExamHeader extends StatelessWidget {
  const ExamHeader({
    super.key,
    required this.pageController,
    required this.currentPageIndex,
    required this.examQuestions,
  });

  final PageController pageController;
  final List<ExamQuestionEntity> examQuestions;

  final int currentPageIndex;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamCubit, ExamState>(
      buildWhen: (previous, current) =>
          current is ExamRunningState &&
          (previous is! ExamRunningState),
      builder: (context, state) {
        if (state is! ExamRunningState) {
          return const SizedBox();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "السؤال ${currentPageIndex + 1} / ${examQuestions.length}",
                style: TextStyles.semiBold15,
              ),
              const TimerWidget(),
              SelectExamQuestion(
                examQuestions: examQuestions,
                pageController: pageController,
                currentPageIndex: currentPageIndex,
              ),
            ],
          ),
        );
      },
    );
  }
}
