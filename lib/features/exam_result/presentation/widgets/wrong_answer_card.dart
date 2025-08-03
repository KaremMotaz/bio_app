import 'package:flutter/material.dart';

import '../../../../core/entities/base_question_entity.dart';
import '../../../../core/models/exam_question_model.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';

class WrongAnswerCard<T extends BaseQuestionEntity> extends StatelessWidget {
  const WrongAnswerCard({super.key, required this.question});
  final T question;

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
