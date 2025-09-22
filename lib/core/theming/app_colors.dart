import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  static const Color white = Color(0xffffffff);
  static const Color transparent = Color(0x00000000);
  static const Color black = Color(0xff000000);
  static const Color grey = Color(0xff9E9E9E);
  static const Color grey300 = Color(0xffE0E0E0);
  static const Color grey600 = Color(0xff757575);
  static const Color grey200 = Color(0xffEEEEEE);
  static const Color grey100 = Color(0xffF5F5F5);
  static const Color green = Color(0xff4CAF50);
  static const Color green600 = Color(0xff43A047);
  static const Color mainGreen = Color(0xff57cc02);
  static const Color darkGreen = Color(0xff57a601);
  static const Color lighterGreen = Color(0xffd7ffb8);
  static const Color red = Color(0xffF44336);
  static const Color red600 = Color(0xffE53935);
  static const Color lightRed = Color(0xffff4b4c);
  static const Color lighterRed = Color(0xffffdfe0);
  static const Color darkRed = Color(0xffe92b2c);
  static const Color amber = Color(0xffFFC107);
  static const Color amberAccent = Color(0xffFFD740);
  static const Color orange = Color(0xffFF9800);
  static const Color orange50 = Color(0xffFFF3E0);
  static const Color yellow = Color(0xffFFEB3B);
  static const Color lightGray = Color(0xffe5e5e5);
  static const Color lighterGray = Color(0xffEDEDED);
  static const Color gray = Color(0xffaeaeac);
  static const Color lighterBlue = Color(0xffddf3fe);
  static const Color blue = Color(0xff2196F3);
  static const Color lightBlueBackground = Color(0xffF7F7F7);
  static const Color lightBlue = Color(0xff84d7ff);
  static const Color darkBlue = Color(0xff1cacf2);
  static const Color buttonBlue = Color(0xff1cb0f6);
  static const Color darkerBlue = Color(0xff1a98d5);
  static const Color moreDarkerBlue = Color(0xCC3775FF);
  static const Color mainBlue = Color(0xff0096C7);
  static const Color mainBlueOld = Color(0xff425D8C);
  static const Color mainpurple = Color(0xffFF598C);
  static const Color darkModeGray = Color(0xff202124);

  static final List<List<Color>> predefinedColorPairsForUnits = [
    [const Color(0xffFF79A2), const Color(0xffFFC9D9)],
    [const Color(0xffDB65BE), const Color(0xffFFDAF9)],
    [const Color(0xff96CD83), const Color(0xffE4F185)],
    [const Color(0xffA19CF7), const Color(0xffE2E1FF)],
    [const Color(0xff75E2FF), const Color(0xffC6F5FF)],
    [const Color(0xff7BE7C3), const Color(0xffC9FFED)],
    [const Color(0xffFFD682), const Color(0xffFFF3D5)],
    [const Color(0xffFFAFAF), const Color(0xffFFE0E0)],
  ];

  static final List<List<Color>> predefinedColorPairsForChapters = [
    [const Color(0xffFF79A2), const Color(0xffFFC9D9)],
    [const Color(0xffDB65BE), const Color(0xffFFDAF9)],
    [const Color(0xff96CD83), const Color(0xffE4F185)],
    [const Color(0xffA19CF7), const Color(0xffE2E1FF)],
    [const Color(0xff75E2FF), const Color(0xffC6F5FF)],
    [const Color(0xff7BE7C3), const Color(0xffC9FFED)],
    [const Color(0xffFFD682), const Color(0xffFFF3D5)],
    [const Color(0xffFFAFAF), const Color(0xffFFE0E0)],
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
