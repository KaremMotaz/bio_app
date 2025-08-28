import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/exam_question_entity.dart';
import '../manager/exam_questions_cubit/exam_questions_cubit.dart';
import 'exam_question_options.dart';
import 'question_images.dart';
import 'question_widget.dart';

class ExamQuestionCard extends StatelessWidget {
  final ExamQuestionEntity question;
  final Map<String, int> answers;

  const ExamQuestionCard({
    super.key,
    required this.question,
    required this.answers,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 20),
            QuestionWidget<ExamQuestionEntity>(question: question),
            const SizedBox(height: 10),
            QuestionImages<ExamQuestionEntity>(question: question),
            const SizedBox(height: 20),
            ExamQuestionOptions(
              question: question,
              onSelect: (int index) {
                context.read<ExamQuestionsCubit>().selectAnswer(
                  question.index,
                  index,
                );
              },
              answers: answers,
            ),
          ],
        ),
      ),
    );
  }
}
