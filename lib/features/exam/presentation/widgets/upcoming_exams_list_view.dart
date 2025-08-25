import '../../../../core/routing/routes.dart';
import '../../../../core/theming/text_styles.dart';
import '../../domain/entities/exam_entity.dart';
import 'upcoming_exam_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UpcomingExamsListView extends StatelessWidget {
  const UpcomingExamsListView({super.key, required this.exams});

  final List<ExamEntity> exams;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        itemCount: exams.length,
        itemBuilder: (context, index) {
          if (exams[index].isPublished) {
            return GestureDetector(
              onTap: () {
                GoRouter.of(context).push(
                  Routes.examQuestionsView,
                  extra: {
                    'examId': exams[index].id,
                    'examIndex': index,
                    'exams': exams,
                  },
                );
              },
              child: UpcomingExamCard(exam: exams[index]),
            );
          } else {
            return const Text(
              "لا توجد إمتحانات حاليا",
              style: TextStyles.regular14,
            );
          }
        },
      ),
    );
  }
}
