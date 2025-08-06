import '../../../../core/theming/option_style.dart';
import '../../../../core/widgets/image_options.dart';
import '../../../../core/widgets/mcq_options.dart';
import '../../../../core/widgets/true_false_options.dart';
import '../../../../core/entities/base_question_entity.dart';
import '../../../../core/models/exam_question_model.dart';
import 'package:flutter/material.dart';

class ExamQuestionOptions<T extends BaseQuestionEntity>
    extends StatelessWidget {
  const ExamQuestionOptions({
    super.key,
    required this.question,
    required this.onSelect,
    required this.answers,
  });
  final T question;
  final void Function(int index) onSelect;
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
            return OptionStyle.examQuestionStyle(
              isSelected: selectedIndex == index,
            );
          },
        );
      case ExamOptionsType.trueFalseOptions:
        return TrueFalseOptions(
          options: question.options,
          onSelect: onSelect,
          styleBuilder: (int index) {
            return OptionStyle.examQuestionStyle(
              isSelected: selectedIndex == index,
            );
          },
        );
      case ExamOptionsType.imageOptions:
        return ImageOptions(
          options: question.options,
          onSelect: onSelect,
          styleBuilder: (int index) {
            return OptionStyle.examQuestionStyle(
              isSelected: selectedIndex == index,
            );
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
