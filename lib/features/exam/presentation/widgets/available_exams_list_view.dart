import 'package:bio_app/features/exam/presentation/manager/exams_cubit/exams_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/routes.dart';
import '../../domain/entities/exam_entity.dart';
import 'available_exam_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

              await context.read<ExamsCubit>().markExamAsOpened(
                examId: availableExams[index].id,
              );

              router.push(
                Routes.examQuestionsView,
                extra: {
                  'examId': availableExams[index].id,
                  'examIndex': index,
                  'exams': availableExams,
                },
              );
            },
            child: AvailableExamCard(exam: availableExams[index]),
          );
        },
      ),
    );
  }
}
