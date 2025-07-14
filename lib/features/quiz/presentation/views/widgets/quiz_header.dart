import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bio_app/core/theming/assets_data.dart';
import 'package:bio_app/features/quiz/domain/entities/quiz_progress.dart';
import 'package:bio_app/features/quiz/domain/entities/quiz_status.dart';
import 'package:bio_app/features/quiz/presentation/manager/quiz_cubit/quiz_cubit.dart';
import 'package:bio_app/features/quiz/presentation/views/widgets/custom_linear_progress_bar.dart';

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
                      child: Text("لا"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        quizCubit.exitToHome();
                      },
                      child: Text("نعم"),
                    ),
                  ],
                );
              },
            );
          },
          child: SvgPicture.asset(AssetsData.closeIcon, height: 16),
        ),
        SizedBox(width: 16),
        Expanded(child: CustomLinearProgressBar(progress: progress)),
        SizedBox(width: 12),
        Row(
          children: [
            SvgPicture.asset(AssetsData.expIcon),
            SizedBox(width: 4),
            Text(
              "${status.score}",
              style: TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(width: 12),
        Row(
          children: [
            SvgPicture.asset(AssetsData.heartIcon),
            SizedBox(width: 4),
            Text(
              "${status.remainingLives}",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
