import '../../../../core/entities/base_question_entity.dart';
import 'exam_result_images_options.dart';
import 'exam_result_mcq_options.dart';
import 'exam_result_true_false_options.dart';
import '../../../../core/models/exam_question_model.dart';
import 'package:flutter/material.dart';

class ExamQuestionResultOptions<T extends BaseQuestionEntity>
    extends StatelessWidget {
  const ExamQuestionResultOptions({
    super.key,
    required this.question,
    required this.onSelect,
  });
  final T question;
  final void Function(int) onSelect;

  @override
  Widget build(BuildContext context) {
    switch (question.type) {
      case ExamOptionsType.textOptions:
        return ExamResultMcqOptions(
          question: question,
          onSelect: onSelect,
        );
      case ExamOptionsType.trueFalseOptions:
        return ExamResultTrueFalseOptions(
          question: question,
          onSelect: onSelect,
        );
      case ExamOptionsType.imageOptions:
        return ExamResultImagesOptions(
          question: question,
          onSelect: onSelect,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
