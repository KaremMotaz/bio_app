import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/features/quiz/data/models/question_model.dart';
import 'package:bio_app/features/quiz/presentation/extensions/question_model_extension.dart';
import 'package:bio_app/features/quiz/presentation/helpers/quiz_answer_helpers.dart';
import 'package:bio_app/features/quiz/presentation/manager/quiz_cubit/quiz_cubit.dart';
import 'package:bio_app/features/quiz/presentation/views/widgets/question_options_widget.dart';

class QuizBody extends StatelessWidget {
  const QuizBody({
    super.key,
    required this.questionModel,
    required this.selectedAnswerIndex,
    required this.answerState,
  });
  final QuestionModel questionModel;
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

            if (questionModel.hasScenario) ...[
              Text(questionModel.questionScenario!, style: TextStyles.bold17),
              SizedBox(height: 5),
            ],

            Text("- ${questionModel.questionText}", style: TextStyles.bold17),

            SizedBox(height: 10),

            if (questionModel.hasImages) ...[
              const SizedBox(height: 20),
              ...List.generate(questionModel.questionImages!.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      questionModel.questionImages![index],
                      height: 230,
                      width: 300,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              }),
            ],

            ...List.generate(questionModel.options.length, (index) {
              final optionState = getAnswerStateForOption(
                question: questionModel,
                selectedIndex: selectedAnswerIndex ?? -1,
                optionIndex: index,
                currentAnswerState: answerState,
              );

              return GestureDetector(
                onTap: () {
                  context.read<QuizCubit>().selectAnswer(index);
                },
                child: QuestionOptionsWidget(
                  questionModel: questionModel,
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
