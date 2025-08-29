import 'package:flutter/material.dart';

import '../../../../core/functions/format_date_time.dart';
import '../../../../core/theming/text_styles.dart';
import '../../domain/entities/exam_entity.dart';

class PastExamCard extends StatelessWidget {
  final ExamEntity exam;

  const PastExamCard({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
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
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "عرض النتيجة",
                style: TextStyles.regular14.copyWith(
                  color: Colors.green.shade800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
