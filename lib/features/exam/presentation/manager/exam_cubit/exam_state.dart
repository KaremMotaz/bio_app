part of 'exam_cubit.dart';

abstract class ExamState {}

class ExamInitialState extends ExamState {}

class ExamLoadingState extends ExamState {}

class ExamRunningState extends ExamState {
  final ExamEntity exam;
  final Map<String, int> answers;
  final int remainingTimeInSeconds;

  ExamRunningState({
    required this.exam,
    required this.answers,
    required this.remainingTimeInSeconds,
  });

  ExamRunningState copyWith({
    ExamEntity? exam,
    int? currentPageIndex,
    Map<String, int>? answers,
    int? remainingTimeInSeconds,
  }) {
    return ExamRunningState(
      exam: exam ?? this.exam,
      answers: answers ?? this.answers,
      remainingTimeInSeconds:
          remainingTimeInSeconds ??
          this.remainingTimeInSeconds,
    );
  }
}

class ExamSubmittingState extends ExamState {}

class ExamSubmittedState extends ExamState {}

class ExamErrorState extends ExamState {
  final String message;
  ExamErrorState(this.message);
}
