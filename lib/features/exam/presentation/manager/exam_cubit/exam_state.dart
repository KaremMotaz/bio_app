part of 'exam_cubit.dart';

abstract class ExamState {}

class ExamInitialState extends ExamState {}

class ExamLoadingState extends ExamState {}

class ExamLoadedState extends ExamState {
  final ExamEntity exam;
  ExamLoadedState(this.exam);
}

class ExamErrorState extends ExamState {
  final String message;
  ExamErrorState(this.message);
}

class PageChangedState extends ExamState {
  final int pageIndex;

  PageChangedState(this.pageIndex);
}

class AnswerSelectedState extends ExamState {
  final int questionId;
  final int selectedIndex;
  AnswerSelectedState(this.questionId, this.selectedIndex);
}

class ExamSubmittingState extends ExamState {}

class ExamSubmittedState extends ExamState {
  ExamSubmittedState();
}
