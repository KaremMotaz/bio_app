import '../../../../../core/theming/text_styles.dart';

import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/assets_data.dart';
import '../../../../../core/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OTPVerificationViewBody extends StatelessWidget {
  const OTPVerificationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Image.asset(AssetsData.emailNotification, width: 130),
          SizedBox(height: 8),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "تحقق من بريدك",
              style: TextStyles.bold20.copyWith(color: AppColors.mainBlue),
            ),
          ),
          SizedBox(height: 8),

          Text(
            "لقد ارسلنا رابط التحقق إلي بريدك الإلكتروني. يرجى التحقق من بريدك والضغط على الرابط.",
            style: TextStyles.regular14,
          ),
          SizedBox(height: 16),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "بعد التحقق قم بالضغط على الزر التالي ثم تسجيل الدخول.",
              style: TextStyles.regular14,
            ),
          ),
          SizedBox(height: 32),
          AppTextButton(
            buttonText: "التالي",
            textStyle: TextStyles.semiBold16.copyWith(color: Colors.white),
            onPressed: () {
              GoRouter.of(context).push(Routes.signInView);
            },
          ),
        ],
      ),
    );
  }
}
