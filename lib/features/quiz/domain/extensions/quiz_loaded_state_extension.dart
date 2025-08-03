import '../../data/models/quiz_question_model.dart';
import '../../presentation/manager/quiz_cubit/quiz_cubit.dart';
import '../entities/quiz_progress.dart';
import '../entities/quiz_status.dart';

extension QuizLoadedStateX on QuizLoadedState {
  QuizQuestionModel get currentQuestion =>
      questions[progress.currentQuestionIndex];

  int get totalQuestions => questions.length;

  int get currentQuestionIndex => progress.currentQuestionIndex;

  int get answeredQuestionsCount => progress.answeredQuestionsCount;

  int? get currentSelectedAnswerIndex =>
      answerState.selectedAnswers[currentQuestionIndex.toString()];

  String? get explanation => currentQuestion.explanation;

  String get correctAnswerText =>
      currentQuestion.options[currentQuestion.correctIndex];

  int get correctImageAnswerNumber =>
      currentQuestion.correctIndex + 1;
  int get remainingLives => status.remainingLives;

  bool get isLastQuestionFinished =>
      progress.currentQuestionIndex == progress.totalQuestions;

  bool get isCorrectAnswered => answerState.isCorrect!;

  bool get isLastLifeLost => answerState.isLastLifeLost;

  bool get isAnswered => answerState.isAnswered;

  bool get isSelected => answerState.isSelected;

  QuizProgress get quizProgress => QuizProgress(
    currentQuestionIndex: currentQuestionIndex,
    answeredQuestionsCount: answeredQuestionsCount,
    totalQuestions: totalQuestions,
  );

  QuizStatus get quizStatus => QuizStatus(
    score: status.score,
    remainingLives: status.remainingLives,
  );

  Map<String, int?> updateAnswerAt(int index) {
    final Map<String, int?> updated = Map<String, int?>.from(
      answerState.selectedAnswers,
    );
    updated[currentQuestionIndex.toString()] = index;
    return updated;
  }
}
