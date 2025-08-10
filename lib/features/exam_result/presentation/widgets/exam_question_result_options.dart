import 'package:bio_app/features/exam_questions/domain/entities/exam_question_entity.dart';
import 'package:flutter/material.dart';
import '../../../exam_questions/data/models/exam_question_model.dart';
import '../../../../core/theming/option_style.dart';
import '../../../../core/widgets/image_options.dart';
import '../../../../core/widgets/mcq_options.dart';
import '../../../../core/widgets/true_false_options.dart';

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
