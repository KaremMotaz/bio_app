import '../../../../core/models/exam_question_model.dart';
import '../../../../core/entities/exam_question_entity.dart';
import 'exam_images_options.dart';
import 'exam_mcq_options.dart';
import 'exam_true_false_options.dart';
import 'package:flutter/material.dart';

class QuestionOptions extends StatelessWidget {
  const QuestionOptions({
    super.key,
    required this.question,
    this.isEnabled,
  });
  final ExamQuestionEntity question;
  final bool? isEnabled;
  @override
  Widget build(BuildContext context) {
    switch (question.type) {
      case ExamOptionsType.textOptions:
        return ExamMcqOptions(
          question: question,
          isEnabled: isEnabled,
        );
      case ExamOptionsType.trueFalseOptions:
        return ExamTrueFalseOptions(
          question: question,
          isEnabled: isEnabled,
        );
      case ExamOptionsType.imageOptions:
        return ExamImagesOptions(
          question: question,
          isEnabled: isEnabled,
        );
    }
  }
}
