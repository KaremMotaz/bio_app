import 'package:bio_app/features/exam/presentation/manager/exam_cubit/exam_cubit.dart';
import 'package:bio_app/features/exam/presentation/views/widgets/question_card.dart';
import 'package:bio_app/features/exam/presentation/views/widgets/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamView extends StatelessWidget {
  const ExamView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exam')),
      body: BlocBuilder<ExamCubit, ExamState>(
        builder: (context, state) {
          if (state is ExamLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ExamLoaded) {
            final exam = state.exam;
            return Column(
              children: [
                TimerWidget(duration: exam.duration),
                Expanded(
                  child: ListView.builder(
                    itemCount: exam.questions.length,
                    itemBuilder: (context, index) {
                      final question =
                          exam.questions[index];
                      return QuestionCard(
                        question: question,
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<ExamCubit>().submitExam();
                  },
                  child: const Text('Submit Exam'),
                ),
              ],
            );
          } else if (state is ExamSubmitted) {
            return Center(
              child: Text("Exam Result: ${state.result}"),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
