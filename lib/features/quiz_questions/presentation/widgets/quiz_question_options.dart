import '../../domain/entities/quiz_question_entity.dart';
import 'package:flutter/material.dart';
import '../../../../core/services/get_it_service.dart';
import '../../../../core/theming/option_style.dart';
import '../../../../core/widgets/image_options.dart';
import '../../../../core/widgets/mcq_options.dart';
import '../../../../core/widgets/true_false_options.dart';
import '../../data/models/quiz_question_model.dart';
import '../../domain/logic/quiz_helpers.dart';
import '../manager/quiz_questions_cubit/quiz_questions_cubit.dart';

class QuizQuestionOptions extends StatelessWidget {
  const QuizQuestionOptions({
    super.key,
    required this.question,
    required this.onSelect,
    required this.answerState,
  });

  final QuizQuestionEntity question;
  final void Function(int) onSelect;
  final QuizAnswerState answerState;

  @override
  Widget build(BuildContext context) {
    final selectedIndex =
        answerState.selectedAnswers[question.index.toString()] ?? -1;

    OptionStyle getOptionStyle(int index) {
      final QuizHelper helper = getIt<QuizHelper>();
      final state = helper.getAnswerStateForOption(
        question: question,
        selectedIndex: selectedIndex,
        optionIndex: index,
        currentAnswerState: answerState,
      );
      return OptionStyle.quizQuestionStyle(state);
    }

    final options = question.options;

    switch (question.type) {
      case QuizQuestionType.textOptions:
        return McqOptions(
          options: options,
          onSelect: onSelect,
          styleBuilder: getOptionStyle,
        );
      case QuizQuestionType.trueFalseOptions:
        return TrueFalseOptions(
          options: options,
          onSelect: onSelect,
          styleBuilder: getOptionStyle,
        );
      case QuizQuestionType.imageOptions:
        return ImageOptions(
          options: options,
          onSelect: onSelect,
          styleBuilder: getOptionStyle,
        );
    }
  }
}
