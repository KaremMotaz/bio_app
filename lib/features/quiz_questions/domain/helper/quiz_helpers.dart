import 'package:bio_app/features/quiz_questions/domain/entities/quiz_question_entity.dart';
import '../../data/models/quiz_question_model.dart';
import '../../presentation/manager/quiz_questions_cubit/quiz_questions_cubit.dart';

class QuizHelper {
  DateTime? _startTime;

  void startTimer() {
    _startTime = DateTime.now();
  }

  Duration getDuration() {
    if (_startTime == null) return Duration.zero;
    return DateTime.now().difference(_startTime!);
  }

  bool isCorrectAnswer(
    QuizQuestionModel question,
    int? selectedIndex,
  ) {
    return selectedIndex == question.correctIndex;
  }

  int updateRemainingLives(bool isCorrect, int currentLives) {
    return isCorrect ? currentLives : currentLives - 1;
  }

  QuizQuestionAnswerModel getAnswerStateForOption({
    required QuizQuestionEntity question,
    required int selectedIndex,
    required int optionIndex,
    required QuizQuestionAnswerModel currentAnswerState,
  }) {
    return QuizQuestionAnswerModel(
      isSelected: selectedIndex == optionIndex,
      isAnswered: currentAnswerState.isAnswered,
      isCorrect: optionIndex == question.correctIndex,
      selectedAnswers: currentAnswerState.selectedAnswers,
    );
  }
}
