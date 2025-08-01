import '../../../../core/entities/base_question_entity.dart';
import '../../../../core/models/exam_question_model.dart';
import 'exam_images_options.dart';
import 'exam_mcq_options.dart';
import 'exam_true_false_options.dart';
import 'package:flutter/material.dart';

class ExamQuestionOptions<T extends BaseQuestionEntity>
    extends StatelessWidget {
  const ExamQuestionOptions({
    super.key,
    required this.question,
    required this.onSelect,
  });
  final T question;
  final void Function(int index) onSelect;

  @override
  Widget build(BuildContext context) {
    switch (question.type) {
      case ExamOptionsType.textOptions:
        return ExamMcqOptions(question: question, onSelect: onSelect);
      case ExamOptionsType.trueFalseOptions:
        return ExamTrueFalseOptions(
          question: question,
          onSelect: onSelect,
        );
      case ExamOptionsType.imageOptions:
        return ExamImagesOptions(
          question: question,
          onSelect: onSelect,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
