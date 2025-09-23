import 'package:flutter/material.dart';

import '../../../../../core/theming/text_styles.dart';
import 'already_have_an_account.dart';
import 'signup_form.dart';

class SignupViewBody extends StatelessWidget {
  const SignupViewBody({super.key});

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
              "قم بالتسجيل الآن وابدأ في استكشاف كل ما يقدمه تطبيقنا. نحن متحمسون للترحيب بك في مجتمعنا!",
              style: TextStyles.regular14.copyWith(),
            ),
            const SizedBox(height: 36),
            const SignUpForm(),
            const SizedBox(height: 25),
            const Align(
              alignment: AlignmentDirectional.center,
              child: AlreadyHaveAnAccount(),
            ),
          ],
        ),
      ),
    );
  }
}
