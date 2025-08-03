import 'package:flutter/material.dart';

import '../../../../core/theming/app_colors.dart';

class CustomLinearProgressBar extends StatelessWidget {
  const CustomLinearProgressBar({
    super.key,
    required this.progressPercentage,
  });
  final double progressPercentage;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: progressPercentage),
      duration: const Duration(milliseconds: 800),
      builder: (context, animatedProgress, child) {
        return LinearProgressIndicator(
          value: animatedProgress,
          minHeight: 12,
          borderRadius: BorderRadius.circular(5),
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(
            AppColors.mainGreen,
          ),
        );
      },
    );
  }
}
