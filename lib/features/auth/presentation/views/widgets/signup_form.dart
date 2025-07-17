import '../../../../../core/theming/text_styles.dart';

import '../../../../../core/helpers/app_regex.dart';
import '../../../../../core/widgets/app_text_form_field.dart';
import 'password_validations.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const SignUpForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool isPasswordObscureText = true;

  // validation booleans
  bool hasLowerCase = false;
  bool hasUpperCase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  @override
  void initState() {
    setupPasswordControllerListener();
    super.initState();
  }

  @override
  void dispose() {
    widget.emailController.dispose();
    widget.passwordController.dispose();
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "يرجى إدخال بريدك الإلكتروني";
              }
              if (!AppRegex.isEmailValid(value)) {
                return "يرجى إدخال بريد إلكتروني صحيح";
              }
              return null;
            },
            controller: widget.emailController,
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
                return "يرجى إدخال كلمة مرور صحيحة";
              }
              return null;
            },
          ),
          SizedBox(height: 24),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "يجب أن تحتوي كلمة المرور على ما يلي:",
              style: TextStyles.regular14,
            ),
          ),
          SizedBox(height: 10),
          PasswordValidations(
            hasLowerCase: hasLowerCase,
            hasUpperCase: hasUpperCase,
            hasSpecialCharacters: hasSpecialCharacters,
            hasNumber: hasNumber,
            hasMinLength: hasMinLength,
          ),
        ],
      ),
    );
  }

  void setupPasswordControllerListener() {
    widget.passwordController.addListener(() {
      setState(() {
        hasLowerCase = AppRegex.hasLowerCase(widget.passwordController.text);
        hasUpperCase = AppRegex.hasUpperCase(widget.passwordController.text);
        hasSpecialCharacters = AppRegex.hasSpecialCharacter(
          widget.passwordController.text,
        );
        hasNumber = AppRegex.hasNumber(widget.passwordController.text);
        hasMinLength = AppRegex.hasMinLength(widget.passwordController.text);
      });
    });
  }
}
