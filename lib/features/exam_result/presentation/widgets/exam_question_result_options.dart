import 'package:flutter/material.dart';

import '../../../../core/theming/option_style.dart';
import '../../../../core/widgets/image_options.dart';
import '../../../../core/widgets/mcq_options.dart';
import '../../../../core/widgets/true_false_options.dart';
import '../../../exam/data/models/exam_question_model.dart';
import '../../../exam/domain/entities/exam_question_entity.dart';

class ExamQuestionResultOptions
    extends StatelessWidget {
  const ExamQuestionResultOptions({
    super.key,
    required this.question,
    required this.onSelect,
    required this.answers,
  });
  final ExamQuestionEntity question;
  final void Function(int) onSelect;
  final Map<String, int> answers;

  @override
  Widget build(BuildContext context) {
    int? selectedIndex = answers[question.index.toString()];
    switch (question.type) {
      case ExamOptionsType.textOptions:
        return McqOptions(
          options: question.options,
          onSelect: onSelect,
          styleBuilder: (int index) {
            return OptionStyle.examResultQuestionStyle(
              isSelected: selectedIndex == index,
              isCorrect: question.correctIndex == index,
            );
          },
        );
      case ExamOptionsType.trueFalseOptions:
        return TrueFalseOptions(
          options: question.options,
          onSelect: onSelect,
          styleBuilder: (int index) {
            return OptionStyle.examResultQuestionStyle(
              isSelected: selectedIndex == index,
              isCorrect: question.correctIndex == index,
            );
          },
        );
      case ExamOptionsType.imageOptions:
        return ImageOptions(
          options: question.options,
          onSelect: onSelect,
          styleBuilder: (int index) {
            return OptionStyle.examResultQuestionStyle(
              isSelected: selectedIndex == index,
              isCorrect: question.correctIndex == index,
            );
          },
        );
      }
  }
}
