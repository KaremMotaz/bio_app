import 'package:bio_app/features/exam/data/models/exam_question_model.dart';
import 'package:bio_app/features/exam/domain/entities/exam_question_entity.dart';
import 'package:bio_app/features/exam/presentation/views/widgets/exam_images_options.dart';
import 'package:bio_app/features/exam/presentation/views/widgets/exam_mcq_options.dart';
import 'package:bio_app/features/exam/presentation/views/widgets/exam_true_false_options.dart';
import 'package:flutter/material.dart';

class ExamQuestionOptions extends StatelessWidget {
  const ExamQuestionOptions({
    super.key,
    required this.question,
  });
  final ExamQuestionEntity question;
  @override
  Widget build(BuildContext context) {
    switch (question.type) {
      case ExamOptionsType.textOptions:
        return ExamMcqOptions(question: question);
      case ExamOptionsType.trueFalseOptions:
        return ExamTrueFalseOptions(question: question);
      case ExamOptionsType.imageOptions:
        return ExamImagesOptions(question: question);
    }
  }
}
