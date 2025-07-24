import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/features/exam/presentation/manager/exam_cubit/exam_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bio_app/features/exam/domain/entities/question.dart';

class ExamQuestionCard extends StatelessWidget {
  final Question question;

  const ExamQuestionCard({
    super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            SizedBox(height: 20),
        
            if (question.scenario != null) ...[
              Text(
                question.scenario!,
                style: TextStyles.bold17,
              ),
              SizedBox(height: 5),
            ],
        
            Text(
              "- ${question.text}",
              style: TextStyles.bold17,
            ),
        
            SizedBox(height: 10),
        
            if (question.imageUrl != null) ...[
              const SizedBox(height: 20),
              ...List.generate(question.imageUrl!.length, (
                index,
              ) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      question.imageUrl![index],
                      height: 230,
                      width: 300,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              }),
            ],
        
            ...List.generate(question.options.length, (
              index,
            ) {
              final isSelected =
                  context
                      .read<ExamCubit>()
                      .answers[question.id] ==
                  index;
        
              return GestureDetector(
                onTap: () {
                  context.read<ExamCubit>().selectAnswer(
                    question.id,
                    index,
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.blue.shade100
                        : Colors.white,
                    border: Border.all(
                      color: isSelected
                          ? Colors.blue
                          : Colors.grey.shade300,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    question.options[index],
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelected
                          ? Colors.blue
                          : Colors.black,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
