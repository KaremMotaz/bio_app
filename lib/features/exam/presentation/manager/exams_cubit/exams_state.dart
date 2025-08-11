part of 'exams_cubit.dart';

sealed class ExamsState extends Equatable {
  const ExamsState();

  @override
  List<Object> get props => [];
}

final class ExamsInitialState extends ExamsState {}

final class ExamsLoadingState extends ExamsState {}

final class ExamsLoadedState extends ExamsState {
  final List<ExamEntity> exams;
  const ExamsLoadedState(this.exams);
}

final class ExamsErrorState extends ExamsState {
  final String message;
  const ExamsErrorState({required this.message});
}
