import 'package:flutter/material.dart';

import '../../../../core/theming/text_styles.dart';
import '../../domain/entities/exam_entity.dart';
import 'available_exams_list_view.dart';
import 'past_exams_list_view.dart';

class ExamsViewBody extends StatelessWidget {
  const ExamsViewBody({
    super.key,
    required this.availableExams,
    required this.pastExams,
    this.finishedLoading = true,
  });

  final List<ExamEntity> availableExams;
  final List<ExamEntity> pastExams;
  final bool finishedLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("الإمتحانات القادمة", style: TextStyles.bold18),
          const SizedBox(height: 16),
          if (availableExams.isEmpty && finishedLoading)
            const Center(
              child: Text(
                "لا توجد إمتحانات حاليا",
                style: TextStyles.regular14,
              ),
            )
          else
            AvailableExamsListView(availableExams: availableExams),

          const SizedBox(height: 25),

          const Text("الإمتحانات السابقة", style: TextStyles.bold18),
          const SizedBox(height: 16),
          if (pastExams.isEmpty)
            const Center(
              child: Text(
                "لا توجد إمتحانات سابقة",
                style: TextStyles.regular14,
              ),
            )
          else
            PastExamsListView(pastExams: pastExams),
        ],
      ),
    );
  }
}
