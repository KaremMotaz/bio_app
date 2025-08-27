import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routes.dart';
import '../../domain/entities/exam_entity.dart';
import 'past_exam_card.dart';

class PastExamsListView extends StatelessWidget {
  const PastExamsListView({super.key, required this.pastExams});

  final List<ExamEntity> pastExams;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: pastExams.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (pastExams[index].isResultPublished) {
            return GestureDetector(
              onTap: () {
                GoRouter.of(context).push(
                  Routes.examResultView,
                  extra: {
                    'examId': pastExams[index].id,
                    'resultExamIndex': index,
                  },
                );
              },
              child: PastExamCard(exam: pastExams[index]),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
