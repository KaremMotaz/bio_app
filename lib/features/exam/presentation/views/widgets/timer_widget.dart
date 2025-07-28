import 'package:bio_app/features/exam/presentation/manager/exam_cubit/exam_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamCubit, ExamState>(
      buildWhen: (previous, current) =>
          current is ExamRunningState,
      builder: (context, state) {
        if (state is ExamRunningState) {
          final minutes = (state.remainingSeconds ~/ 60)
              .toString()
              .padLeft(2, '0');
          final seconds = (state.remainingSeconds % 60)
              .toString()
              .padLeft(2, '0');
          return Text('$minutes:$seconds');
        } else {
          return const Text('');
        }
      },
    );
  }
}
