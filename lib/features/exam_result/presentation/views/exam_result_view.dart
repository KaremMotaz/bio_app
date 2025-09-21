import 'package:bio_app/core/widgets/custom_app_bar_pop_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theming/app_colors.dart';
import '../manager/exam_result_cubit/exam_result_cubit.dart';
import '../widgets/exam_result_view_body.dart';

class ExamResultView extends StatelessWidget {
  const ExamResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: Navigator.of(context).canPop()
            ? const CustomAppBarPopIcon()
            : null,
        title: const Text('نتيجة الإمتحان'),
      ),
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
              return ExamResultViewBody(state: loadedState);

            case const (ExamResultErrorState):
              return Center(
                child: Text((state as ExamResultErrorState).message),
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
