import '../../data/models/quiz_question_model.dart';

class AnswerEvaluator {
  bool isCorrectAnswer(
    QuizQuestionModel question,
    int? selectedIndex,
  ) {
    return selectedIndex == question.correctAnswerIndex;
  }

  int updateRemainingLives(
    bool isCorrect,
    int currentLives,
  ) {
    return isCorrect ? currentLives : currentLives - 1;
  }
}
