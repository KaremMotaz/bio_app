import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/features/exam/domain/entities/exam_entity.dart';
import 'package:flutter/material.dart';

class UpcomingExamCard extends StatelessWidget {
  final ExamEntity exam;

  const UpcomingExamCard({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(exam.title, style: TextStyles.bold18),
            const SizedBox(height: 8),
            Text(
              "يبدأ: ${exam.startTime}",
              style: TextStyles.regular14,
            ),
          ],
        ),
      ),
    );
  }
}
