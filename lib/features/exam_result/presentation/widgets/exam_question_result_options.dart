import 'package:bio_app/core/theming/option_style.dart';
import 'package:bio_app/core/widgets/image_options.dart';
import 'package:bio_app/core/widgets/mcq_options.dart';
import 'package:bio_app/core/widgets/true_false_options.dart';
import 'package:flutter/material.dart';
import '../../../../core/entities/base_question_entity.dart';
import '../../../../core/models/exam_question_model.dart';

class ExamQuestionResultOptions<T extends BaseQuestionEntity>
    extends StatelessWidget {
  const ExamQuestionResultOptions({
    super.key,
    required this.question,
    required this.onSelect,
    required this.answers,
  });
  final T question;
  final void Function(int) onSelect;
  final Map<String, int> answers;

  @override
  Widget build(BuildContext context) {
    int? selectedIndex = answers[question.id.toString()];
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
      default:
        return const SizedBox.shrink();
    }
  }
}
