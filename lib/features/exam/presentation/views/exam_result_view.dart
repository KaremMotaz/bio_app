import '../../../../core/theming/app_colors.dart';
import '../manager/exam_cubit/exam_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/exam_result_view_body.dart';

class ExamResultView extends StatelessWidget {
  const ExamResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Result"),
      ),
      body: BlocBuilder<ExamCubit, ExamState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (ExamLoadingState):
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainBlue,
                ),
              );

            case const (ExamRunningState):
              final runningState =
                  state as ExamRunningState;
              return ExamResultViewBody(
                exam: runningState.exam,
              );

            case const (ExamErrorState):
              return Center(
                child: Text(
                  (state as ExamErrorState).message,
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
