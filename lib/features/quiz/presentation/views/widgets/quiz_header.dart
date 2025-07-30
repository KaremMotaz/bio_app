import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/theming/assets_data.dart';
import '../../../domain/entities/quiz_progress.dart';
import '../../../domain/entities/quiz_status.dart';
import '../../manager/quiz_cubit/quiz_cubit.dart';
import 'custom_linear_progress_bar.dart';

class QuizHeader extends StatelessWidget {
  const QuizHeader({super.key, required this.progress, required this.status});
  final QuizProgress progress;
  final QuizStatus status;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            final quizCubit = context.read<QuizCubit>();
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("إنهاء الكويز"),
                  content: const Text("هل أنت متأكد إنك عايز تخرج من الكويز؟"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("لا"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        quizCubit.exitToHome();
                      },
                      child: const Text("نعم"),
                    ),
                  ],
                );
              },
            );
          },
          child: SvgPicture.asset(AssetsData.closeIcon, height: 16),
        ),
        const SizedBox(width: 16),
        Expanded(child: CustomLinearProgressBar(progress: progress)),
        const SizedBox(width: 12),
        Row(
          children: [
            SvgPicture.asset(AssetsData.expIcon),
            const SizedBox(width: 4),
            Text(
              "${status.score}",
              style: const TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        Row(
          children: [
            SvgPicture.asset(AssetsData.heartIcon),
            const SizedBox(width: 4),
            Text(
              "${status.remainingLives}",
              style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
