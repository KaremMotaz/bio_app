import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/assets_data.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../manager/login_cubit/login_cubit.dart';
import 'dont_have_an_account.dart';
import 'login_form.dart';
import 'or_divider.dart';
import 'social_login_button.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "مرحبًا بعودتك",
              style: TextStyles.bold20.copyWith(
                color: AppColors.mainBlue,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "أهلاً بالطالب المميز! مستعد تكمّل التعلم؟",
              style: TextStyles.regular14,
            ),
            const SizedBox(height: 32),
            const SignInForm(),
            const SizedBox(height: 25),
            const DontHaveAnAccount(),
            const SizedBox(height: 25),
            const OrDivider(),
            const SizedBox(height: 20),
            SocialLoginButton(
              title: "تسجيل بواسطة جوجل",
              imageLink: AssetsData.googleIcon,
              onPressed: () {
                context.read<LoginCubit>().signinWithGoogle();
              },
            ),
            const SizedBox(height: 15),
            SocialLoginButton(
              title: "تسجيل بواسطة فيسبوك",
              imageLink: AssetsData.faceBookIcon,
              onPressed: () {
                context.read<LoginCubit>().signinWithFacebook();
              },
            ),
          ],
        ),
      ),
    );
  }
}
