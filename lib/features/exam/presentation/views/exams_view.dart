import 'package:bio_app/features/exam/presentation/manager/exams_cubit/exams_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';

class ExamsView extends StatelessWidget {
  const ExamsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Available Exams"),
      ),
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
              return Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListView.builder(
                      itemCount: state.exams.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                          ),
                          onPressed: () {
                            GoRouter.of(context).push(
                              Routes.examQuestionsView,
                              extra: {
                                'examId': state.exams[index].id,
                                'examIndex': index,
                                'exams': state.exams,
                              },
                            );
                          },
                          child: const Text(
                            "Go to Exam",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    ListView.builder(
                      itemCount: state.exams.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors.mainBlue,
                          ),
                          onPressed: () {
                            GoRouter.of(context).push(
                              Routes.examResultView,
                              extra: {
                                'examId': state.exams[index].id,
                                'resultExamIndex': index,
                              },
                            );
                          },
                          child: const Text(
                            "Go to Exam Result",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            } else if (state is ExamsErrorState) {
              return Center(child: Text(state.message));
            } else {
              return const Text("data is null");
            }
          },
        ),
      ),
    );
  }
}
