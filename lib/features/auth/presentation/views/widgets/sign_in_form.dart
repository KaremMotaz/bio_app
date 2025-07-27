import 'package:flutter/material.dart';

import '../../../../../core/helpers/app_regex.dart';
import '../../../../../core/widgets/app_text_form_field.dart';

class SignInForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const SignInForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool isPasswordObscureText = true;

  @override
  void dispose() {
    widget.passwordController.dispose();
    widget.emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          AppTextFormField(
            textInputType: TextInputType.emailAddress,
            hintText: "البريد الإلكتروني",
            controller: widget.emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "يرجى إدخال بريدك الإلكتروني";
              }
              if (!AppRegex.isEmailValid(value)) {
                return "يرجى إدخال بريد إلكتروني صالح";
              }
              return null;
            },
          ),
          SizedBox(height: 18),
          AppTextFormField(
            hintText: "كلمة المرور",
            isObscureText: isPasswordObscureText,
            controller: widget.passwordController,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isPasswordObscureText = !isPasswordObscureText;
                });
              },
              icon: Icon(
                isPasswordObscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "يرجى إدخال كلمة المرور";
              }
              if (!AppRegex.isPasswordValid(value)) {
                return "يرجى إدخال كلمة مرور صالحة";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
