part of 'quiz_questions_cubit.dart';

@immutable
sealed class QuizQuestionsState {}

final class QuizQuestionsInitialState extends QuizQuestionsState {}

final class QuizQuestionsLoadingState extends QuizQuestionsState {}

class QuizQuestionsLoadedState extends QuizQuestionsState {
  final List<QuizQuestionModel> questions;
  final QuizProgress progress;
  final QuizStatus status;
  final QuizAnswerState answerState;

  QuizQuestionsLoadedState({
    required this.questions,
    required this.progress,
    required this.status,
    required this.answerState,
  });

  QuizQuestionsLoadedState copyWith({
    QuizProgress? progress,
    QuizStatus? status,
    QuizAnswerState? answerState,
  }) => QuizQuestionsLoadedState(
    questions: questions,
    progress: progress ?? this.progress,
    status: status ?? this.status,
    answerState: answerState ?? this.answerState,
  );
}

class QuizQuestionsFinishedState extends QuizQuestionsState {
  final QuizResult result;
  QuizQuestionsFinishedState({required this.result});
}

class QuizQuestionsErrorState extends QuizQuestionsState {
  final String message;

  QuizQuestionsErrorState({required this.message});
}

class QuizQuestionsExitToHomeState extends QuizQuestionsState {}
