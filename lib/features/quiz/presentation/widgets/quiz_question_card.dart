import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../exam/presentation/widgets/question_images.dart';
import '../../../exam/presentation/widgets/question_widget.dart';
import '../../domain/entities/quiz_question_entity.dart';
import '../manager/quiz_cubit/quiz_cubit.dart';
import 'quiz_question_options.dart';

class QuizQuestionCard extends StatelessWidget {
  const QuizQuestionCard({
    super.key,
    required this.question,
    required this.answerState,
  });
  final QuizQuestionEntity question;
  final QuizAnswerState answerState;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 20),
            QuestionWidget<QuizQuestionEntity>(question: question),
            const SizedBox(height: 10),
            QuestionImages<QuizQuestionEntity>(question: question),
            const SizedBox(height: 20),
            QuizQuestionOptions<QuizQuestionEntity>(
              question: question,
              onSelect: (int index) {
                context.read<QuizCubit>().selectAnswer(index);
              },
              answerState: answerState,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
