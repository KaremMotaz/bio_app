import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  static const Color mainGreen = Color(0xff57cc02);
  static const Color darkGreen = Color(0xff57a601);
  static const Color lighterGreen = Color(0xffd7ffb8);
  static const Color lightRed = Color(0xffff4b4c);
  static const Color lighterRed = Color(0xffffdfe0);
  static const Color darkRed = Color(0xffe92b2c);
  static const Color lightGray = Color(0xffe5e5e5);
  static const Color lighterGray = Color(0xffEDEDED);
  static const Color gray = Color(0xffaeaeac);
  static const Color lighterBlue = Color(0xffddf3fe);
  static const Color lightBlue = Color(0xff84d7ff);
  static const Color darkBlue = Color(0xff1cacf2);
  static const Color buttonBlue = Color(0xff1cb0f6);
  static const Color darkerBlue = Color(0xff1a98d5);
  static const Color moreDarkerBlue = Color(0xCC3775FF);
  static const Color mainBlue = Color(0xff425D8C);
  static const Color mainpurple = Color(0xffFF598C);
  static const Color darkModeGray = Color(0xff202124);

  static final List<List<int>> predefinedColorPairsForUnits = [
    [0xffFF79A2, 0xffFFC9D9],
    [0xffDB65BE, 0xffFFDAF9],
    [0xff96CD83, 0xffE4F185],
    [0xffA19CF7, 0xffE2E1FF],
    [0xff75E2FF, 0xffC6F5FF],
    [0xff7BE7C3, 0xffC9FFED],
    [0xffFFD682, 0xffFFF3D5],
    [0xffFFAFAF, 0xffFFE0E0],
  ];

  static final List<List<int>> predefinedColorPairsForChapters = [
    [0xffffffff, 0xffFFC9D9],
    [0xffffffff, 0xffFFDAF9],
    [0xffffffff, 0xffE4F185],
    [0xffffffff, 0xffE2E1FF],
    [0xffffffff, 0xffC6F5FF],
    [0xffffffff, 0xffC9FFED],
    [0xffffffff, 0xffFFF3D5],
    [0xffffffff, 0xffFFE0E0],
  ];

  static final List<Color> profileAvatarColors = [
    const Color(0xff1cb0f6),
    const Color(0xff58a700),
    const Color(0xffff4b4c),
    const Color(0xffff9600),
    const Color(0xffce82ff),
  ];
  static Color getRandomColor() {
    final Random random = Random();
    return profileAvatarColors[random.nextInt(
      profileAvatarColors.length,
    )];
  }
}
