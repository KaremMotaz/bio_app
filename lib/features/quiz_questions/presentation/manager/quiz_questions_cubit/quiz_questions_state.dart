part of 'quiz_questions_cubit.dart';

@immutable
sealed class QuizQuestionsState {}

final class QuizQuestionsInitialState extends QuizQuestionsState {}

final class QuizQuestionsLoadingState extends QuizQuestionsState {}

class QuizQuestionsLoadedState extends QuizQuestionsState {
  final List<QuizQuestionModel> questions;
  final QuizProgressModel progress;
  final QuizStatusModel status;
  final QuizQuestionAnswerModel answerState;

  QuizQuestionsLoadedState({
    required this.questions,
    required this.progress,
    required this.status,
    required this.answerState,
  });

  QuizQuestionsLoadedState copyWith({
    QuizProgressModel? progress,
    QuizStatusModel? status,
    QuizQuestionAnswerModel? answerState,
  }) => QuizQuestionsLoadedState(
    questions: questions,
    progress: progress ?? this.progress,
    status: status ?? this.status,
    answerState: answerState ?? this.answerState,
  );
}

class QuizQuestionsFinishedState extends QuizQuestionsState {
  final QuizResultModel result;
  QuizQuestionsFinishedState({required this.result});
}

class QuizQuestionsErrorState extends QuizQuestionsState {
  final String message;

  QuizQuestionsErrorState({required this.message});
}

class QuizQuestionsExitToHomeState extends QuizQuestionsState {}
