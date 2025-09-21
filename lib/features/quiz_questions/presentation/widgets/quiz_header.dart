import 'package:bio_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/functions/show_confirm_dialog.dart';
import '../../../../core/theming/assets_data.dart';
import '../../data/models/quiz_progress_model.dart';
import '../../data/models/quiz_status_model.dart';
import '../manager/quiz_questions_cubit/quiz_questions_cubit.dart';
import 'custom_linear_progress_bar.dart';

class QuizHeader extends StatelessWidget {
  const QuizHeader({
    super.key,
    required this.progress,
    required this.status,
  });
  final QuizProgressModel progress;
  final QuizStatusModel status;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            final quizCubit = context.read<QuizQuestionsCubit>();
            showConfirmDialog(
              context: context,
              buttonText: "إنهاء",
              bodyContent: "هل أنت متأكد إنك تريد إنهاء الكويز؟",
              title: "إنهاء الكويز",
              buttonColor: const Color(0xffdb2323),
              onPressed: () async {
                GoRouter.of(context).pop();
                quizCubit.exitToHome();
              },
            );
          },
          child: SvgPicture.asset(AssetsData.closeIcon, height: 16),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: CustomLinearProgressBar(
            progressPercentage: progress.progressPercentage,
          ),
        ),
        const SizedBox(width: 12),
        Row(
          children: [
            SvgPicture.asset(AssetsData.expIcon),
            const SizedBox(width: 4),
            Text(
              "${status.score.toInt()}",
              style: const TextStyle(
                color: AppColors.amber,
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
              style: const TextStyle(
                color: AppColors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
