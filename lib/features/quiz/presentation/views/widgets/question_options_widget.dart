import 'package:flutter/material.dart';
import 'package:bio_app/features/quiz/data/models/question_model.dart';
import 'package:bio_app/features/quiz/presentation/manager/quiz_cubit/quiz_cubit.dart';
import 'package:bio_app/features/quiz/presentation/views/widgets/image_options_widget.dart';
import 'package:bio_app/features/quiz/presentation/views/widgets/text_options_widget.dart';
import 'package:bio_app/features/quiz/presentation/views/widgets/true_false_0ptions_widget.dart';

class QuestionOptionsWidget extends StatelessWidget {
  const QuestionOptionsWidget({
    super.key,
    required this.questionModel,
    required this.index,
    required this.answerState,
  });
  final QuestionModel questionModel;
  final QuizAnswerState answerState;
  final int index;

  @override
  Widget build(BuildContext context) {
    switch (questionModel.questionType) {
      case QuestionType.textChoices:
        return TextOptionsWidget(
          questionModel: questionModel,
          index: index,
          answerState: answerState,
        );
      case QuestionType.imageChoices:
        return ImageOptionsWidget(
          questionModel: questionModel,
          index: index,
          answerState: answerState,
        );
      case QuestionType.trueFalse:
        return TrueFalseOptionsWidget(
          questionModel: questionModel,
          index: index,
          answerState: answerState,
        );
    }
  }
}
