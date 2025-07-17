import '../../../../../core/theming/text_styles.dart';

import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  const AlreadyHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        children: [
          TextSpan(
            text: "لا تمتلك حساباً؟ ",
            style: TextStyles.medium16,
          ),
          const TextSpan(
            text: " ",
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                GoRouter.of(context).push(Routes.signInView);
              },
            text: "تسجيل الدخول",
            style: TextStyles.medium16.copyWith(
              color: AppColors.darkBlue,
            ),
          ),
        ],
      ),
    );
  }
}
