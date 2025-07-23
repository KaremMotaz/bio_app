import '../../../../../core/theming/text_styles.dart' show TextStyles;
import '../../../../../core/widgets/app_text_button.dart';
import '../../manager/signup_cubit/signup_cubit.dart';
import 'already_have_an_account.dart';
import 'signup_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
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
              "قم بالتسجيل الآن وابدأ في استكشاف كل ما يقدمه تطبيقنا. نحن متحمسون للترحيب بك في مجتمعنا!",
              style: TextStyles.regular14.copyWith(),
            ),
            SizedBox(height: 36),
            SignUpForm(
              emailController: emailController,
              passwordController: passwordController,
              formKey: formKey,
            ),
            SizedBox(height: 25),
            AppTextButton(
              buttonText: "إنشاء حساب جديد",
              textStyle: TextStyles.semiBold16.copyWith(color: Colors.white),
              onPressed: () {
                validateThenSignup(context);
                emailController.clear();
                passwordController.clear();
              },
            ),
            SizedBox(height: 25),
            const Align(
              alignment: AlignmentDirectional.center,
              child: AlreadyHaveAnAccount(),
            ),
          ],
        ),
      ),
    );
  }

  void validateThenSignup(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<SignupCubit>().signupWithEmailAndPassword(
        passwordController: passwordController,
        emailController: emailController,
      );
    }
  }
}
