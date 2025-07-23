part of 'exam_cubit.dart';

abstract class ExamState {}

class ExamInitial extends ExamState {}

class ExamLoading extends ExamState {}

class ExamLoaded extends ExamState {
  final Exam exam;
  ExamLoaded(this.exam);
}

class ExamError extends ExamState {
  final String message;
  ExamError(this.message);
}

class AnswerSelected extends ExamState {
  final String questionId;
  final int selectedIndex;
  AnswerSelected(this.questionId, this.selectedIndex);
}

class ExamSubmitting extends ExamState {}

class ExamSubmitted extends ExamState {
  final ExamResultEntity result;
  ExamSubmitted(this.result);
}
