import 'package:bio_app/core/entities/exam_question_entity.dart';
import 'package:bio_app/core/models/exam_question_model.dart';
import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class WrongAnswerCard extends StatelessWidget {
  const WrongAnswerCard({super.key, required this.question});
  final ExamQuestionEntity question;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration:  BoxDecoration(
        color: AppColors.lighterRed,
        border: Border.all(color: AppColors.darkRed, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "إجابة خاطئة",
            style: TextStyles.extraBold24.copyWith(
              color: AppColors.darkRed,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "الإجابة:",
            style: TextStyles.extraBold21.copyWith(
              color: AppColors.darkRed,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            question.type == ExamOptionsType.imageOptions
                ? "الإختيار رقم ${question.correctIndex + 1}"
                : question.options[question.correctIndex],
            style: TextStyles.semiBold18.copyWith(
              color: AppColors.darkRed,
            ),
          ),

          if (question.explanation != null) ...[
            const SizedBox(height: 5),
            Text(
              "السبب:",
              style: TextStyles.extraBold21.copyWith(
                color: AppColors.darkRed,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              question.explanation!,
              style: TextStyles.semiBold18.copyWith(
                color: AppColors.darkRed,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
