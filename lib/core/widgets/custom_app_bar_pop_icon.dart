import '../theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBarPopIcon extends StatelessWidget {
  const CustomAppBarPopIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back_ios_new,
        color: AppColors.grey600,
        size: 18,
      ),
      onPressed: () => GoRouter.of(context).pop(),
    );
  }
}
