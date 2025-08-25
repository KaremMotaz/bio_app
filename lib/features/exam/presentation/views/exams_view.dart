import '../widgets/exams_view_body.dart';
import '../manager/exams_cubit/exams_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theming/app_colors.dart';

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
              return ExamsViewBody(exams: state.exams);
            } else if (state is ExamsErrorState) {
              return Center(child: Text(state.message));
            } else {
              return const Text("لا يوجد إمتحانات حاليا");
            }
          },
        ),
      ),
    );
  }
}
