import 'package:bio_app/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

abstract class ThemeManager {
  static ThemeData getAppTheme() {
    return ThemeData(
      fontFamily: "Cairo",
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyles.bold17.copyWith(
          fontFamily: 'Cairo',
          color: Colors.grey.shade600,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
    );
  }
}
