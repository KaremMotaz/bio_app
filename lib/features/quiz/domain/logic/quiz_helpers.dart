// lib/features/quiz/domain/logic/quiz_helpers.dart

import '../../data/models/quiz_question_model.dart';
import '../../presentation/manager/quiz_cubit/quiz_cubit.dart';
import '../../../../../core/entities/base_question_entity.dart';

class QuizHelper {
  DateTime? _startTime;

  void startTimer() {
    _startTime = DateTime.now();
  }

  Duration getDuration() {
    if (_startTime == null) return Duration.zero;
    return DateTime.now().difference(_startTime!);
  }


  bool isCorrectAnswer(QuizQuestionModel question, int? selectedIndex) {
    return selectedIndex == question.correctIndex;
  }


  int updateRemainingLives(bool isCorrect, int currentLives) {
    return isCorrect ? currentLives : currentLives - 1;
  }


  QuizAnswerState getAnswerStateForOption({
    required BaseQuestionEntity question,
    required int selectedIndex,
    required int optionIndex,
    required QuizAnswerState currentAnswerState,
  }) {
    return QuizAnswerState(
      isSelected: selectedIndex == optionIndex,
      isAnswered: currentAnswerState.isAnswered,
      isCorrect: optionIndex == question.correctIndex,
      selectedAnswers: currentAnswerState.selectedAnswers,
    );
  }
}
