import 'package:flutter/material.dart';

import '../../../../core/theming/app_colors.dart';
import '../manager/quiz_cubit/quiz_cubit.dart';

class OptionStyle {
  final QuizAnswerState answerState;

  OptionStyle({required this.answerState});

  bool? get isCorrectAnswer => answerState.isCorrect;
  bool get isSelected => answerState.isSelected;
  bool get isAnswered => answerState.isAnswered;

  bool get isWrongSelected => isSelected && !isCorrectAnswer!;

  Color get backgroundColor {
    if (isAnswered && isCorrectAnswer!) return AppColors.lighterGreen;
    if (isAnswered && isWrongSelected) return AppColors.lighterRed;
    if (isSelected) return AppColors.lighterBlue;
    return Colors.white;
  }

  Color get borderColor {
    if (isAnswered && isCorrectAnswer!) return AppColors.mainGreen;
    if (isAnswered && isWrongSelected) return AppColors.lightRed;
    if (isSelected) return AppColors.lightBlue;
    return const Color.fromARGB(255, 218, 218, 218);
  }

  Color get shadowColor {
    if (isAnswered && isCorrectAnswer!) return AppColors.mainGreen;
    if (isAnswered && isWrongSelected) return AppColors.lightRed;
    if (isSelected) return AppColors.lightBlue;
    return Colors.white;
  }

  Color get fontColor {
    if (isAnswered && isCorrectAnswer!) return AppColors.mainGreen;
    if (isAnswered && isWrongSelected) return AppColors.lightRed;
    if (isSelected) return Colors.blue;
    return AppColors.gray;
  }

  Color get circleBackgroundColor {
    if (isAnswered && isCorrectAnswer!) return AppColors.mainGreen;
    if (isAnswered && isWrongSelected) return AppColors.lightRed;
    if (isSelected) return AppColors.darkBlue;
    return Colors.grey;
  }
}
