import '../../data/models/quiz_question_model.dart';

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
}
