part of 'quiz_cubit.dart';

@immutable
sealed class QuizState {}

final class QuizInitialState extends QuizState {}

final class QuizLoadingState extends QuizState {}

class QuizLoadedState extends QuizState {
  final List<QuestionModel> questions;
  final QuizProgress progress;
  final QuizStatus status;
  final QuizAnswerState answerState;

  QuizLoadedState({
    required this.questions,
    required this.progress,
    required this.status,
    required this.answerState,
  });

  QuizLoadedState copyWith({
    QuizProgress? progress,
    QuizStatus? status,
    QuizAnswerState? answerState,
  }) => QuizLoadedState(
    questions: questions,
    progress: progress ?? this.progress,
    status: status ?? this.status,
    answerState: answerState ?? this.answerState,
  );
}

class QuizFinishedState extends QuizState {
  final QuizResult result;
  QuizFinishedState({required this.result});
}

class QuizErrorState extends QuizState {
  final String message;

  QuizErrorState({required this.message});
}

class QuizExitToHomeState extends QuizState {}
