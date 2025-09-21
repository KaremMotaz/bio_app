import 'package:bio_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/functions/build_snack_bar.dart';
import '../../../../../core/helpers/app_regex.dart';
import '../../../../../core/theming/assets_data.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/widgets/app_text_button.dart';
import '../../../../../core/widgets/app_text_form_field.dart';
import '../../manager/reset_password_cubit/reset_password_cubit.dart';

class ResetPasswordViewBody extends StatefulWidget {
  const ResetPasswordViewBody({super.key});

  @override
  State<ResetPasswordViewBody> createState() =>
      _ResetPasswordViewBodyState();
}

final TextEditingController emailController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _ResetPasswordViewBodyState
    extends State<ResetPasswordViewBody> {
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "يرجى إدخال بريدك الإلكتروني لتلقي رابط إعادة تعيين كلمة السر",
            style: TextStyles.regular14,
          ),
          Image.asset(AssetsData.forgotPassword),
          Form(
            key: _formKey,
            child: AppTextFormField(
              hintText: "البريد الإلكتروني",
              controller: emailController,
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
          ),
          const Spacer(),
          AppTextButton(
            buttonText: "إرسال",
            textStyle: TextStyles.semiBold16.copyWith(
              color: AppColors.white,
            ),
            onPressed: () {
              validateThenSendLinkToResetPassword(context);
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void validateThenSendLinkToResetPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<ResetPasswordCubit>().sendLinkToResetPassword(
        emailController: emailController,
      );
      successSnackBar(
        context: context,
        message:
            "تم ارسال رابط استعادة كلمة السر إلى بريدك الإلكتروني.",
      );
    }
  }
}
