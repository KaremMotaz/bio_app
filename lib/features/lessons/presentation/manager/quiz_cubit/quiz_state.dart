part of 'quiz_cubit.dart';

sealed class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];
}

final class QuizInitialState extends QuizState {}

class QuizLoadingState extends QuizState {}

class QuizLoadedState extends QuizState {
  final List<QuizEntity> quizzes;
  const QuizLoadedState({required this.quizzes});
}

class QuizErrorState extends QuizState {
  final String message;
  const QuizErrorState({required this.message});
}