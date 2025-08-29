part of '../../presentation/manager/quiz_questions_cubit/quiz_questions_cubit.dart';

class QuizQuestionAnswerModel {
  final bool isSelected;
  final bool isAnswered;
  final bool? isCorrect;
  final bool isLastLifeLost;
  final Map<String, int?> selectedAnswers;

  const QuizQuestionAnswerModel({
    required this.isSelected,
    required this.selectedAnswers,
    this.isCorrect,
    this.isAnswered = false,
    this.isLastLifeLost = false,
  });

  QuizQuestionAnswerModel copyWith({
    bool? isSelected,
    bool? isCorrect,
    bool? isAnswered,
    bool? isLastLifeLost,
    Map<String, int?>? selectedAnswers,
  }) {
    return QuizQuestionAnswerModel(
      isSelected: isSelected ?? this.isSelected,
      isCorrect: isCorrect ?? this.isCorrect,
      isAnswered: isAnswered ?? this.isAnswered,
      isLastLifeLost: isLastLifeLost ?? this.isLastLifeLost,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
    );
  }
}
