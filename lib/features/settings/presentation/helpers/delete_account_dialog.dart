import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/app_text_form_field.dart';

deleteAccountDialog({
  required BuildContext context,
  required void Function() onPressed,
  required String title,
  required String hintText,
  required TextEditingController controller,
  required Function(String?) validator,
  TextInputType? textInputType,
  bool? isObscureText,
  Widget? suffixIcon,
}) {
  final formKey = GlobalKey<FormState>();
  return Dialog(
    child: Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 20,vertical: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyles.bold18.copyWith(
                    color: AppColors.darkModeGray,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: AppColors.darkModeGray,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            AppTextFormField(
              backgroundColor: const Color.fromARGB(
                255,
                244,
                241,
                241,
              ),
              textInputType: textInputType,
              hintText: hintText,
              controller: controller,
              validator: validator,
              isObscureText: isObscureText,
              suffixIcon: suffixIcon,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: AppTextButton(
                    buttonText: "إلغاء",
                    backgroundColor:
                        Theme.of(context).brightness ==
                            Brightness.dark
                        ? AppColors.lighterGray
                        : const Color.fromARGB(255, 233, 231, 231),
                    verticalPadding: 10,
                    buttonHeight: 30,
                    borderRadius: 12,
                    textStyle: TextStyles.semiBold16.copyWith(
                      color: AppColors.darkModeGray,
                      fontSize: 16,
                    ),
                    onPressed: () {
                      controller.clear();
                      GoRouter.of(context).pop();
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: AppTextButton(
                    buttonText: "إرسال",
                    backgroundColor: AppColors.mainBlue,
                    verticalPadding: 10,
                    buttonHeight: 30,
                    borderRadius: 12,
                    textStyle: TextStyles.semiBold16.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        onPressed();
                        GoRouter.of(context).pop();
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
