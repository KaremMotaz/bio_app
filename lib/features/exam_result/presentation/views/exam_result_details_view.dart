import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../exam/presentation/manager/exam_cubit/exam_cubit.dart';
import '../manager/exam_result_cubit/exam_result_cubit.dart';
import '../widgets/exam_result_details_view_body.dart';

class ExamResultDetailsView extends StatelessWidget {
  const ExamResultDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ExamResultCubit, ExamResultState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (ExamResultLoadingState):
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainBlue,
                ),
              );

            case const (ExamResultLoadedState):
              final loadedState = state as ExamResultLoadedState;
              return ExamResultDetailsViewBody(
                exam: loadedState.exam,
                answers: loadedState.answers,
              );

            case const (ExamResultErrorState):
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
