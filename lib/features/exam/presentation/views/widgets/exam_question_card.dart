import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/features/exam/presentation/manager/exam_cubit/exam_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bio_app/features/exam/domain/entities/exam_question_entity.dart';

class ExamQuestionCard extends StatelessWidget {
  final ExamQuestionEntity question;

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
              "${(question.id + 1)}- ${question.text}",
              style: TextStyles.bold17,
            ),

            SizedBox(height: 10),

            if (question.imageUrl != null) ...[
              const SizedBox(height: 20),
              ...List.generate(question.imageUrl!.length, (
                index,
              ) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                  ),
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
              return BlocBuilder<ExamCubit, ExamState>(
                builder: (context, state) {
                  final isSelected =
                      context
                          .read<ExamCubit>()
                          .answers[question.id.toString()] ==
                      index;

                  return GestureDetector(
                    onTap: () {
                      context
                          .read<ExamCubit>()
                          .selectAnswer(question.id, index);
                    },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.lightBlue
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isSelected
                                ? AppColors.lightBlue
                                : Colors.white,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        question.options[index],
                        style: TextStyles.semiBold18
                            .copyWith(
                              color: isSelected
                                  ? AppColors.darkBlue
                                  : Colors.black,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
