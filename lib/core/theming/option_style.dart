import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class OptionStyle {
  final Color backgroundColor;
  final Color borderColor;
  final Color shadowColor;
  final TextStyle textStyle;

  const OptionStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.shadowColor,
    required this.textStyle,
  });

  static OptionStyle defaultStyle(bool isSelected, bool isEnabled) {
    return OptionStyle(
      backgroundColor: Colors.white,
      borderColor: isSelected && isEnabled
          ? AppColors.lightBlue
          : Colors.grey.shade300,
      shadowColor: isSelected && isEnabled
          ? AppColors.lightBlue
          : Colors.white,
      textStyle: TextStyles.semiBold18.copyWith(
        color: isSelected && isEnabled
            ? AppColors.darkBlue
            : Colors.black,
      ),
    );
  }
}