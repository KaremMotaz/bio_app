import 'package:bio_app/core/routing/routes.dart';
import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/core/widgets/bloc_button.dart';
import 'package:bio_app/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/app_regex.dart';
import '../../../../../core/widgets/app_text_form_field.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController emailController =
      TextEditingController();
  final TextEditingController passwordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPasswordObscureText = true;

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
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
            controller: emailController,
            maxLines: 1,
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
                return "يرجى إدخال كلمة مرور صالحة";
              }
              return null;
            },
          ),
          const SizedBox(height: 5),
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
          const SizedBox(height: 25),
          BlocButton<LoginCubit, LoginState>(
            label: "تسجيل دخول",
            isLoading: (state) => state is LoginLoadingState,
            onPressed: () {
              validateThenLogin(context);
              emailController.clear();
              passwordController.clear();
            },
          ),
        ],
      ),
    );
  }

  void validateThenLogin(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<LoginCubit>().signinWithEmailAndPassword(
        passwordController: passwordController,
        emailController: emailController,
      );
    }
  }
}
