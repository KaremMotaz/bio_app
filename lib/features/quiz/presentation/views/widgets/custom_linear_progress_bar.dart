import 'package:flutter/material.dart';

import '../../../../../core/theming/app_colors.dart';
import '../../../domain/entities/quiz_progress.dart';

class CustomLinearProgressBar extends StatelessWidget {
  const CustomLinearProgressBar({super.key, required this.progress});
  final QuizProgress progress;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: progress.progressPercentage),
      duration: const Duration(milliseconds: 800),
      builder: (context, animatedProgress, child) {
        return LinearProgressIndicator(
          value: animatedProgress,
          minHeight: 12,
          borderRadius: BorderRadius.circular(5),
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.mainGreen),
        );
      },
    );
  }
}
