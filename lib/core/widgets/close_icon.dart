import 'package:bio_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CloseIcon extends StatelessWidget {
  const CloseIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: IconButton(
        onPressed: () {
          GoRouter.of(context).pop();
        },
        icon: const Icon(
          Icons.close_rounded,
          color: AppColors.darkModeGray,
        ),
      ),
    );
  }
}
