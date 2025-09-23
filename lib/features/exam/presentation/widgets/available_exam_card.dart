import '../../../../core/theming/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/functions/format_date_time.dart';
import '../../../../core/theming/text_styles.dart';
import '../../domain/entities/exam_entity.dart';

class AvailableExamCard extends StatelessWidget {
  final ExamEntity exam;

  const AvailableExamCard({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: const Border(
          right: BorderSide(color: AppColors.blue, width: 10),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xfff4f7fc),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(exam.title, style: TextStyles.bold18),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.calendar_month, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    formatExamTime(exam.startTime, exam.endTime),
                    style: TextStyles.regular14,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    "مدة الإمتحان: ${exam.endTime.difference(exam.startTime).inMinutes} دقيقة",
                    style: TextStyles.regular14,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
