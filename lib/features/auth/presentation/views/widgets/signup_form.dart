import 'package:bio_app/core/widgets/bloc_button.dart';
import 'package:bio_app/features/auth/presentation/manager/signup_cubit/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/app_regex.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/widgets/app_text_form_field.dart';
import 'password_validations.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController emailController =
      TextEditingController();
  final TextEditingController passwordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
            controller: emailController,
          ),
          const SizedBox(height: 18),
          AppTextFormField(
            hintText: "كلمة المرور",
            isObscureText: isPasswordObscureText,
            controller: passwordController,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isPasswordObscureText = !isPasswordObscureText;
                });
              },
              icon: Icon(
                isPasswordObscureText
                    ? Icons.visibility_off
                    : Icons.visibility,
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
          const SizedBox(height: 24),
          const Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "يجب أن تحتوي كلمة المرور على ما يلي:",
              style: TextStyles.regular14,
            ),
          ),
          const SizedBox(height: 10),
          PasswordValidations(
            hasLowerCase: hasLowerCase,
            hasUpperCase: hasUpperCase,
            hasSpecialCharacters: hasSpecialCharacters,
            hasNumber: hasNumber,
            hasMinLength: hasMinLength,
          ),
          const SizedBox(height: 25),
          BlocButton<SignupCubit, SignupState>(
            label: "إنشاء حساب جديد",
            isLoading: (state) => state is SignupLoadingState,
            onPressed: () {
              validateThenSignup(context);
              emailController.clear();
              passwordController.clear();
            },
          ),
        ],
      ),
    );
  }

  void setupPasswordControllerListener() {
    passwordController.addListener(() {
      setState(() {
        hasLowerCase = AppRegex.hasLowerCase(passwordController.text);
        hasUpperCase = AppRegex.hasUpperCase(passwordController.text);
        hasSpecialCharacters = AppRegex.hasSpecialCharacter(
          passwordController.text,
        );
        hasNumber = AppRegex.hasNumber(passwordController.text);
        hasMinLength = AppRegex.hasMinLength(passwordController.text);
      });
    });
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
