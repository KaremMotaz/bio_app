import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/text_styles.dart';

class DontHaveAnAccount extends StatelessWidget {
  const DontHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        children: [
          const TextSpan(text: "لا تمتلك حساباً؟ ", style: TextStyles.medium16),
          const TextSpan(
            text: " ",
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                GoRouter.of(context).push(Routes.signUpView);
              },
            text: "إنشاء حساب",
            style: TextStyles.medium16.copyWith(
              color: AppColors.mainBlue,
            ),
          ),
        ],
      ),
    );
  }
}
