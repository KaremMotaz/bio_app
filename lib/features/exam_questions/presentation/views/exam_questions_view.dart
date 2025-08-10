import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theming/app_colors.dart';
import '../manager/exam_questions_cubit/exam_questions_cubit.dart';
import '../widgets/exam_questions_view_body.dart';
import 'exam_finished_view.dart';

class ExamQuestionsView extends StatelessWidget {
  final int examIndex;
  final String examId;
  const ExamQuestionsView({
    super.key,
    required this.examIndex,
    required this.examId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: BlocBuilder<ExamQuestionsCubit, ExamQuestionsState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (ExamQuestionsLoadingState):
            case const (ExamQuestionsSubmittingState):
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainBlue,
                ),
              );

            case const (ExamQuestionsRunningState):
              final runningState = state as ExamQuestionsRunningState;
              return ExamQuestionsViewBody(
                examQuestions: runningState.examQuestions,
                answers: runningState.answers,
                examId: examId,
              );

            case const (ExamQuestionsSubmittedState):
              return const ExamFinishedView();

            case const (ExamQuestionsErrorState):
              return Center(
                child: Text(
                  (state as ExamQuestionsErrorState).message,
                ),
              );

            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
