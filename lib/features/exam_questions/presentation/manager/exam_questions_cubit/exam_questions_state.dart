part of 'exam_questions_cubit.dart';

abstract class ExamQuestionsState {}

class ExamQuestionsInitialState extends ExamQuestionsState {}

class ExamQuestionsLoadingState extends ExamQuestionsState {}

class ExamQuestionsRunningState extends ExamQuestionsState {
  final List<ExamEntity> exams;
  final List<ExamQuestionEntity> examQuestions;
  final Map<String, int> answers;
  final int remainingTimeInSeconds;

  ExamQuestionsRunningState({
    required this.exams,
    required this.answers,
    required this.remainingTimeInSeconds,
    required this.examQuestions,
  });

  ExamQuestionsRunningState copyWith({
    required List<ExamEntity> exams,
    List<ExamQuestionEntity>? examQuestions,
    int? currentPageIndex,
    Map<String, int>? answers,
    int? remainingTimeInSeconds,
  }) {
    return ExamQuestionsRunningState(
      exams: exams,
      examQuestions: this.examQuestions,
      answers: answers ?? this.answers,
      remainingTimeInSeconds:
          remainingTimeInSeconds ?? this.remainingTimeInSeconds,
    );
  }
}

class ExamQuestionsSubmittingState extends ExamQuestionsState {}

class ExamQuestionsSubmittedState extends ExamQuestionsState {}

class ExamQuestionsErrorState extends ExamQuestionsState {
  final String message;
  ExamQuestionsErrorState({required this.message});
}
