import 'package:bio_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 21,
      height: 21,
      child: CircularProgressIndicator(color: AppColors.white),
    );
  }
}
