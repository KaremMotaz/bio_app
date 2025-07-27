import '../theming/text_styles.dart';
import 'package:flutter/material.dart';

import '../theming/app_colors.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.textStyle,
    this.borderRadius,
    this.backgroundColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.buttonWidth,
    this.buttonHieght,
  });
  final String buttonText;
  final TextStyle? textStyle;
  final VoidCallback onPressed;
  final double? borderRadius;
  final Color? backgroundColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? buttonWidth;
  final double? buttonHieght;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape:
            WidgetStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  borderRadius ?? 12,
                ),
              ),
            ),
        backgroundColor: WidgetStatePropertyAll<Color>(
          backgroundColor ?? AppColors.mainBlue,
        ),
        padding: WidgetStatePropertyAll<EdgeInsets>(
          EdgeInsets.symmetric(
            horizontal: horizontalPadding ?? 12,
            vertical: verticalPadding ?? 14,
          ),
        ),
        fixedSize: WidgetStatePropertyAll(
          Size(
            buttonWidth ?? double.maxFinite,
            buttonHieght ?? 50,
          ),
        ),
      ),
      child: Text(
        buttonText,
        style: textStyle ?? TextStyles.semiBold15.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
