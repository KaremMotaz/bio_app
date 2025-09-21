import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

void successSnackBar({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 4),
      content: customSnackbar(
        message: message,
        color: AppColors.green,
        icon: Icons.check_circle,
        titleWord: "نجاح",
        context: context,
      ),
    ),
  );
}

void errorSnackBar({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 4),
      content: customSnackbar(
        message: message,
        color: AppColors.red,
        icon: Icons.cancel,
        titleWord: "خطأ",
        context: context,
      ),
    ),
  );
}

void warningSnackBar({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 4),
      content: customSnackbar(
        message: message,
        color: AppColors.yellow,
        icon: Icons.warning,
        titleWord: "خد بالك",
        context: context,
      ),
    ),
  );
}

Widget customSnackbar({
  required String titleWord,
  required String message,
  required Color color,
  required IconData icon,
  required BuildContext context,
}) {
  bool isArabic = Directionality.of(context) == TextDirection.rtl;
  return ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: const BorderSide(color: AppColors.transparent),
          left: isArabic
              ? const BorderSide(color: AppColors.transparent)
              : BorderSide(color: color, width: 10),
          right: isArabic
              ? BorderSide(color: color, width: 10)
              : const BorderSide(color: AppColors.transparent),
          top: const BorderSide(color: AppColors.transparent),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          Icon(icon, color: color, size: 30),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleWord,
                  style: TextStyles.semiBold16.copyWith(
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  message,
                  // overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: AppColors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
