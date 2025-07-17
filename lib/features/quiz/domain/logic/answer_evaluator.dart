import '../../data/models/question_model.dart';

class AnswerEvaluator {
  bool isCorrectAnswer(QuestionModel question, int? selectedIndex) {
    return selectedIndex == question.correctAnswerIndex;
  }

  int updateRemainingLives(bool isCorrect, int currentLives) {
    return isCorrect ? currentLives : currentLives - 1;
  }
}
