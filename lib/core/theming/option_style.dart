import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class OptionStyle {
  final Color backgroundColor;
  final Color borderColor;
  final Color shadowColor;
  final TextStyle textStyle;
  final Color? circleBackgroundColor;

  const OptionStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.shadowColor,
    required this.textStyle,
    this.circleBackgroundColor,
  });

  static OptionStyle examQuestionStyle({required bool isSelected}) {
    return OptionStyle(
      backgroundColor: Colors.white,
      borderColor: isSelected
          ? AppColors.lightBlue
          : Colors.grey.shade300,
      shadowColor: isSelected ? AppColors.lightBlue : Colors.white,
      circleBackgroundColor: isSelected
          ? AppColors.darkBlue
          : Colors.grey,
      textStyle: TextStyles.semiBold18.copyWith(
        color: isSelected ? AppColors.darkBlue : Colors.black,
      ),
    );
  }

  static OptionStyle examResultQuestionStyle({
    required bool isSelected,
    required bool isCorrect,
  }) {
    final bool isWrong = isSelected && !isCorrect;

    return OptionStyle(
      backgroundColor: isCorrect
          ? AppColors.lighterGreen
          : isWrong
          ? AppColors.lighterRed
          : Colors.white,
      borderColor: isCorrect
          ? AppColors.mainGreen
          : isWrong
          ? AppColors.lightRed
          : Colors.grey.shade300,
      shadowColor: isCorrect
          ? AppColors.mainGreen
          : isWrong
          ? AppColors.lightRed
          : Colors.white,
      circleBackgroundColor: isCorrect
          ? AppColors.mainGreen
          : isWrong
          ? AppColors.lightRed
          : Colors.grey,
      textStyle: TextStyles.semiBold18.copyWith(
        color: isCorrect
            ? AppColors.mainGreen
            : isWrong
            ? AppColors.lightRed
            : Colors.black,
      ),
    );
  }
}
