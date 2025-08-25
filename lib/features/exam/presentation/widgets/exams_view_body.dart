import '../../../../core/theming/text_styles.dart';
import '../../domain/entities/exam_entity.dart';
import 'past_exams_list_view.dart';
import 'upcoming_exams_list_view.dart';
import 'package:flutter/material.dart';

class ExamsViewBody extends StatelessWidget {
  const ExamsViewBody({super.key, required this.exams});

  final List<ExamEntity> exams;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("الإمتحانات القادمة", style: TextStyles.bold18),
          const SizedBox(height: 10),
          if (exams.isEmpty)
            const Text(
              "لا توجد إمتحانات حاليا",
              style: TextStyles.regular14,
            )
          else
            UpcomingExamsListView(exams: exams),

          const SizedBox(height: 30),

          const Text("الإمتحانات السابقة", style: TextStyles.bold18),
          const SizedBox(height: 10),
          if (exams.isEmpty)
            const Text(
              "لا توجد إمتحانات سابقة",
              style: TextStyles.regular14,
            )
          else
            PastExamsListView(exams: exams),
        ],
      ),
    );
  }
}
