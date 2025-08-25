import '../../../../core/routing/routes.dart';
import '../../domain/entities/exam_entity.dart';
import 'past_exam_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PastExamsListView extends StatelessWidget {
  const PastExamsListView({super.key, required this.exams});

  final List<ExamEntity> exams;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: exams.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (exams[index].isResultPublished) {
            return GestureDetector(
              onTap: () {
                GoRouter.of(context).push(
                  Routes.examResultView,
                  extra: {
                    'examId': exams[index].id,
                    'resultExamIndex': index,
                  },
                );
              },
              child: PastExamCard(exam: exams[index]),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
