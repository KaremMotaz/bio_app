import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/features/exam/domain/entities/exam_entity.dart';
import 'package:bio_app/features/exam/presentation/manager/exam_cubit/exam_cubit.dart';
import 'package:bio_app/features/exam/presentation/views/widgets/select_exam_question.dart';
import 'package:bio_app/features/exam/presentation/views/widgets/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamHeader extends StatelessWidget {
  const ExamHeader({
    super.key,
    required this.exam,
    required this.pageController,
  });
  final PageController pageController;
  final ExamEntity exam;

  @override
  Widget build(BuildContext context) {
    ExamCubit cubit = context.read<ExamCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SelectExamQuestion(
          exam: exam,
          cubit: cubit,
          pageController: pageController,
        ),
        TimerWidget(),
        Text(
          "السؤال ${cubit.currentPageIndex + 1} / ${exam.questions.length}",
          style: TextStyles.semiBold15,
        ),
      ],
    );
  }
}
