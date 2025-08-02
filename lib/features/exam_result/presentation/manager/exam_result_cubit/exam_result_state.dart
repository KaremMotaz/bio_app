part of 'exam_result_cubit.dart';

sealed class ExamResultState extends Equatable {
  const ExamResultState();

  @override
  List<Object> get props => [];
}

final class ExamResultInitialState extends ExamResultState {}

final class ExamResultLoadingState extends ExamResultState {}

class ExamResultLoadedState extends ExamResultState {
  final ExamEntity exam;
  final Map<String, int> answers;
  final int studentScore;
  final int maxScore;
  final double percentage;
  final bool isPassed;

  const ExamResultLoadedState({
    required this.exam,
    required this.studentScore,
    required this.maxScore,
    required this.percentage,
    required this.isPassed,
    required this.answers,
  });
}

class ExamResultErrorState extends ExamResultState {
  final String message;

  const ExamResultErrorState({required this.message});
}
