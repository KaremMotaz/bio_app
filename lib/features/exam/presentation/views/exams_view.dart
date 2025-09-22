import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theming/app_colors.dart';
import '../manager/exams_cubit/exams_cubit.dart';
import '../manager/exams_cubit/exams_state.dart';
import '../widgets/exams_view_body.dart';

class ExamsView extends StatelessWidget {
  const ExamsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الإمتحانات")),
      body: SizedBox(
        width: double.infinity,
        child: BlocBuilder<ExamsCubit, ExamsState>(
          builder: (context, state) {
            if (state is ExamsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainBlue,
                ),
              );
            } else if (state is ExamsLoadedState) {
              if (state.availableExams.isEmpty &&
                  state.pastExams.isEmpty) {
                return const Center(
                  child: Text("لا يوجد إمتحانات حاليا"),
                );
              }
              return ExamsViewBody(
                availableExams: state.availableExams,
                pastExams: state.pastExams,
                finishedLoading: true,
              );
            } else if (state is ExamsErrorState) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
