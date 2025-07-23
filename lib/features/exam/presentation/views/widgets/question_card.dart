import 'package:bio_app/features/exam/presentation/manager/exam_cubit/exam_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bio_app/features/exam/domain/entities/question.dart';

class QuestionCard extends StatelessWidget {
  final Question question;

  const QuestionCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (question.imageUrl != null)
            Image.network(question.imageUrl!),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(question.text, style: const TextStyle(fontSize: 18)),
          ),
          ...List.generate(
            question.options.length,
            (i) => RadioListTile(
              title: Text(question.options[i]),
              value: i,
              groupValue: context.read<ExamCubit>().answers[question.id],
              onChanged: (val) {
                context.read<ExamCubit>().selectAnswer(question.id, val!);
              },
            ),
          )
        ],
      ),
    );
  }
}
