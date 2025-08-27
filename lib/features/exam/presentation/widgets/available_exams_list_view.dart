import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/functions/build_snack_bar.dart';
import '../../../../core/routing/routes.dart';
import '../../domain/entities/exam_entity.dart';
import 'available_exam_card.dart';

class AvailableExamsListView extends StatelessWidget {
  const AvailableExamsListView({
    super.key,
    required this.availableExams,
  });

  final List<ExamEntity> availableExams;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        itemCount: availableExams.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              final router = GoRouter.of(context);

              // await context.read<ExamsCubit>().markExamAsOpened(
              //   examId: availableExams[index].id,
              // );
              
              if (DateTime.now().isAfter(
                    availableExams[index].startTime,
                  ) ||
                  DateTime.now().isAtSameMomentAs(
                    availableExams[index].startTime,
                  )) {
                router.push(
                  Routes.examQuestionsView,
                  extra: {
                    'examId': availableExams[index].id,
                    'examIndex': index,
                    'exams': availableExams,
                  },
                );
              } else {
                warningSnackBar(
                  context: context,
                  message: "لم يحن وقت الإمتحان بعد",
                );
              }
            },
            child: AvailableExamCard(exam: availableExams[index]),
          );
        },
      ),
    );
  }
}
