import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theming/app_colors.dart';
import '../theming/text_styles.dart';
import '../widgets/app_text_button.dart';

showConfirmDialog({
  required BuildContext context,
  required String buttonText,
  required String bodyContent,
  required String title,
  required Color buttonColor,
  required VoidCallback onPressed,
  String? cancelButtonText,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: AppColors.white,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 20,
            end: 20,
            top: 12,
            bottom: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: TextStyles.bold20),
                  IconButton(
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    icon: const Icon(Icons.close_rounded, size: 26),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(bodyContent, style: TextStyles.bold17),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: AppTextButton(
                      buttonText: cancelButtonText ?? "إلغاء",
                      backgroundColor: const Color(0xffeaeaec),
                      verticalPadding: 5,
                      buttonHeight: 30,
                      borderRadius: 12,
                      textStyle: TextStyles.semiBold16.copyWith(
                        color: AppColors.darkModeGray,
                        fontSize: 16,
                      ),
                      onPressed: () {
                        GoRouter.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: AppTextButton(
                      buttonText: buttonText,
                      backgroundColor: buttonColor,
                      verticalPadding: 5,
                      buttonHeight: 30,
                      borderRadius: 12,
                      textStyle: TextStyles.semiBold16.copyWith(
                        color: AppColors.white,
                        fontSize: 16,
                      ),
                      onPressed: onPressed,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      );
    },
  );
}
