import '../../data/models/quiz_question_model.dart';
import '../../presentation/manager/quiz_questions_cubit/quiz_questions_cubit.dart';
import '../../data/models/quiz_progress_model.dart';
import '../../data/models/quiz_status_model.dart';

extension QuizLoadedStateX on QuizQuestionsLoadedState {
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

  QuizProgressModel get quizProgress => QuizProgressModel(
    currentQuestionIndex: currentQuestionIndex,
    answeredQuestionsCount: answeredQuestionsCount,
    totalQuestions: totalQuestions,
  );

  QuizStatusModel get quizStatus => QuizStatusModel(
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
