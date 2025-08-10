import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theming/app_colors.dart';
import '../manager/exam_cubit/exam_cubit.dart';
import '../widgets/exam_view_body.dart';
import 'exam_finished_view.dart';

class ExamView extends StatelessWidget {
  const ExamView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: BlocBuilder<ExamCubit, ExamState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (ExamLoadingState):
            case const (ExamSubmittingState):
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainBlue,
                ),
              );

            case const (ExamRunningState):
              final runningState = state as ExamRunningState;
              return ExamViewBody(
                examQuestions: runningState.examQuestions,
                answers: runningState.answers,
              );

            case const (ExamSubmittedState):
              return const ExamFinishedView();

            case const (ExamErrorState):
              return Center(
                child: Text((state as ExamErrorState).message),
              );

            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
