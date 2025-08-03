import 'package:bio_app/core/services/get_it_service.dart';
import 'package:bio_app/features/quiz/domain/logic/quiz_helpers.dart';

import '../../../../core/entities/base_question_entity.dart';
import '../../../../core/theming/option_style.dart';
import '../../../../core/widgets/image_options.dart';
import '../../../../core/widgets/mcq_options.dart';
import '../../../../core/widgets/true_false_options.dart';
import '../../data/models/quiz_question_model.dart';
import '../manager/quiz_cubit/quiz_cubit.dart';
import 'package:flutter/material.dart';

class QuizQuestionOptions<T extends BaseQuestionEntity>
    extends StatelessWidget {
  const QuizQuestionOptions({
    super.key,
    required this.question,
    required this.onSelect,
    required this.answerState,
  });

  final T question;
  final void Function(int) onSelect;
  final QuizAnswerState answerState;

  @override
  Widget build(BuildContext context) {
    final selectedIndex =
        answerState.selectedAnswers[question.id.toString()] ?? -1;

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
      case QuizQuestionType.textChoices:
        return McqOptions(
          options: options,
          onSelect: onSelect,
          styleBuilder: getOptionStyle,
        );
      case QuizQuestionType.trueFalse:
        return TrueFalseOptions(
          options: options,
          onSelect: onSelect,
          styleBuilder: getOptionStyle,
        );
      case QuizQuestionType.imageChoices:
        return ImageOptions(
          options: options,
          onSelect: onSelect,
          styleBuilder: getOptionStyle,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
