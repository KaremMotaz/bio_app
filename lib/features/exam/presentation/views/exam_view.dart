import 'package:bio_app/features/exam/presentation/manager/exam_cubit/exam_cubit.dart';
import 'package:bio_app/features/exam/presentation/views/widgets/exam_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamView extends StatelessWidget {
  const ExamView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ExamCubit, ExamState>(
        builder: (context, state) {
          if (state is ExamLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (state is ExamLoadedState) {
            final exam = state.exam;
            return ExamViewBody(exam: exam);
          } else if (state is ExamErrorState) {
            return Center(child: Text(state.message));
          } else if (state is AnswerSelectedState) {
            final exam = context
                .read<ExamCubit>()
                .currentExam;
            return ExamViewBody(exam: exam!);
          } else if (state is PageChangedState) {
            final exam = context
                .read<ExamCubit>()
                .currentExam;
            return ExamViewBody(exam: exam!);
          } else if (state is ExamSubmittingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (state is ExamSubmittedState) {
            return Center(
              child: Text("Exam Result: ${state.result}"),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
