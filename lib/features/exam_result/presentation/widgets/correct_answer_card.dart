import '../../../exam/domain/entities/exam_question_entity.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class CorrectAnswerCard extends StatelessWidget {
  const CorrectAnswerCard({super.key, required this.question});
  final ExamQuestionEntity question;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lighterGreen,
        border: Border.all(color: AppColors.mainGreen, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "إجابة صحيحة",
            style: TextStyles.extraBold24.copyWith(
              color: AppColors.darkGreen,
            ),
          ),
          const SizedBox(height: 8),
          if (question.explanation != null) ...[
            Text(
              question.explanation!,
              style: TextStyles.semiBold18.copyWith(
                color: AppColors.darkGreen,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
