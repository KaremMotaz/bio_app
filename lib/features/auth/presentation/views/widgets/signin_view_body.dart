import '../../../../../core/theming/text_styles.dart';
import '../../manager/login_cubit/login_cubit.dart';

import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/assets_data.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/widgets/app_text_button.dart';
import 'dont_have_an_account.dart';
import 'sign_in_form.dart';
import 'or_divider.dart';
import 'social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SigninViewBody extends StatefulWidget {
  const SigninViewBody({super.key});

  @override
  State<SigninViewBody> createState() => _SigninViewBodyState();
}

class _SigninViewBodyState extends State<SigninViewBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "مرحبًا بعودتك",
              style: TextStyles.bold20.copyWith(color: AppColors.mainBlue),
            ),
            SizedBox(height: 8),
            Text(
              "نحن متحمسون لعودتك، لا يمكننا الانتظار لمعرفة ما كنت تفعله منذ آخر تسجيل دخول لك.",
              style: TextStyles.regular14,
            ),
            SizedBox(height: 32),
            SignInForm(
              emailController: emailController,
              passwordController: passwordController,
              formKey: formKey,
            ),
            SizedBox(height: 5),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: () {
                  GoRouter.of(context).push(Routes.forgotPasswordView);
                },
                child: Text(
                "نسيت كلمة المرور؟",
                  style: TextStyles.regular13.copyWith(
                    color: AppColors.mainBlue,
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            AppTextButton(
              buttonText: "تسجيل دخول",
              textStyle: TextStyles.semiBold16.copyWith(color: Colors.white),
              onPressed: () {
                validateThenSignin(context);
                emailController.clear();
                passwordController.clear();
              },
            ),
            SizedBox(height: 25),
            const DontHaveAnAccount(),
            SizedBox(height: 25),
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

  void validateThenSignin(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<LoginCubit>().signinWithEmailAndPassword(
        passwordController: passwordController,
        emailController: emailController,
      );
    }
  }
}
