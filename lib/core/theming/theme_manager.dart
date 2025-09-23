import 'app_colors.dart';
import 'text_styles.dart';
import 'package:flutter/material.dart';

abstract class ThemeManager {
  static ThemeData getAppTheme() {
    return ThemeData(
      fontFamily: "Cairo",
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        elevation: 0,
        titleTextStyle: TextStyles.bold17.copyWith(
          fontFamily: 'Cairo',
          color: AppColors.grey600,
        ),
        iconTheme: const IconThemeData(color: AppColors.black),
        centerTitle: true,
      ),
    );
  }
}
