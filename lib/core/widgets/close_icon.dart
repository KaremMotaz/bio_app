import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theming/app_colors.dart';

class CloseIcon extends StatelessWidget {
  const CloseIcon({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: IconButton(
        onPressed: () {
          GoRouter.of(context).pop();
        },
        icon: Icon(
          Icons.close_rounded,
          color: color ?? AppColors.darkModeGray,
        ),
      ),
    );
  }
}
