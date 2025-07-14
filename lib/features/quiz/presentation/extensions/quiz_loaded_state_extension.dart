import 'package:bio_app/features/quiz/data/models/question_model.dart';
import 'package:bio_app/features/quiz/domain/entities/quiz_progress.dart';
import 'package:bio_app/features/quiz/domain/entities/quiz_status.dart';
import 'package:bio_app/features/quiz/presentation/manager/quiz_cubit/quiz_cubit.dart';

extension QuizLoadedStateX on QuizLoadedState {
  QuestionModel get currentQuestion => questions[progress.currentQuestionIndex];

  int get totalQuestions => questions.length;

  int get currentQuestionIndex => progress.currentQuestionIndex;

  int get answeredQuestionsCount => progress.answeredQuestionsCount;

  int? get currentSelectedAnswerIndex =>
      answerState.selectedAnswers[currentQuestionIndex];

  String? get explanation => currentQuestion.explanation;

  String get correctAnswerText =>
      currentQuestion.options[currentQuestion.correctAnswerIndex];

  int get correctImageAnswerNumber => currentQuestion.correctAnswerIndex + 1;
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

  QuizStatus get quizStatus =>
      QuizStatus(score: status.score, remainingLives: status.remainingLives);

  Map<int, int?> updateAnswerAt(int index) {
    final updated = Map<int, int?>.from(answerState.selectedAnswers);
    updated[currentQuestionIndex] = index;
    return updated;
  }
}
