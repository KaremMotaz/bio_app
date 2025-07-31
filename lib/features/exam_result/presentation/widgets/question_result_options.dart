import 'package:bio_app/features/exam_result/presentation/widgets/exam_result_images_options.dart';
import 'package:bio_app/features/exam_result/presentation/widgets/exam_result_mcq_options.dart';
import 'package:bio_app/features/exam_result/presentation/widgets/exam_result_true_false_options.dart';
import '../../../../core/models/exam_question_model.dart';
import '../../../../core/entities/exam_question_entity.dart';
import 'package:flutter/material.dart';

class QuestionResultOptions extends StatelessWidget {
  const QuestionResultOptions({
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
        return ExamResultMcqOptions(
          question: question,
          isEnabled: isEnabled,
        );
      case ExamOptionsType.trueFalseOptions:
        return ExamResultTrueFalseOptions(
          question: question,
          isEnabled: isEnabled,
        );
      case ExamOptionsType.imageOptions:
        return ExamResultImagesOptions(
          question: question,
          isEnabled: isEnabled,
        );
    }
  }
}
