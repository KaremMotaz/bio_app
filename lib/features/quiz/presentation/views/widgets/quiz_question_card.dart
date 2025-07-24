import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theming/text_styles.dart';
import '../../../data/models/question_model.dart';
import '../../extensions/question_model_extension.dart';
import '../../helpers/quiz_answer_helpers.dart';
import '../../manager/quiz_cubit/quiz_cubit.dart';
import 'question_options_widget.dart';

class QuizQuestionCard extends StatelessWidget {
  const QuizQuestionCard({
    super.key,
    required this.question,
    required this.selectedAnswerIndex,
    required this.answerState,
  });
  final QuestionModel question;
  final int? selectedAnswerIndex;
  final QuizAnswerState answerState;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            SizedBox(height: 20),

            if (question.hasScenario) ...[
              Text(
                question.questionScenario!,
                style: TextStyles.bold17,
              ),
              SizedBox(height: 5),
            ],

            Text(
              "- ${question.questionText}",
              style: TextStyles.bold17,
            ),

            SizedBox(height: 10),

            if (question.hasImages) ...[
              const SizedBox(height: 20),
              ...List.generate(
                question.questionImages!.length,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                      child: Image.asset(
                        question.questionImages![index],
                        height: 230,
                        width: 300,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            ],

            ...List.generate(question.options.length, (
              index,
            ) {
              final optionState = getAnswerStateForOption(
                question: question,
                selectedIndex: selectedAnswerIndex ?? -1,
                optionIndex: index,
                currentAnswerState: answerState,
              );

              return GestureDetector(
                onTap: () {
                  context.read<QuizCubit>().selectAnswer(
                    index,
                  );
                },
                child: QuestionOptionsWidget(
                  question: question,
                  index: index,
                  answerState: optionState,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
