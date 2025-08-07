part of 'quiz_questions_cubit.dart';

class QuizAnswerState {
  final bool isSelected;
  final bool isAnswered;
  final bool? isCorrect;
  final bool isLastLifeLost;
  final Map<String, int?> selectedAnswers;

  const QuizAnswerState({
    required this.isSelected,
    required this.selectedAnswers,
    this.isCorrect,
    this.isAnswered = false,
    this.isLastLifeLost = false,
  });

  QuizAnswerState copyWith({
    bool? isSelected,
    bool? isCorrect,
    bool? isAnswered,
    bool? isLastLifeLost,
    Map<String, int?>? selectedAnswers,
  }) {
    return QuizAnswerState(
      isSelected: isSelected ?? this.isSelected,
      isCorrect: isCorrect ?? this.isCorrect,
      isAnswered: isAnswered ?? this.isAnswered,
      isLastLifeLost: isLastLifeLost ?? this.isLastLifeLost,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
    );
  }
}
