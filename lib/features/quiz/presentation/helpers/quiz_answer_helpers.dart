import '../../data/models/question_model.dart';
import '../manager/quiz_cubit/quiz_cubit.dart';

QuizAnswerState getAnswerStateForOption({
  required QuestionModel question,
  required int selectedIndex,
  required int optionIndex,
  required QuizAnswerState currentAnswerState,
}) {
  return QuizAnswerState(
    isSelected: selectedIndex == optionIndex,
    isAnswered: currentAnswerState.isAnswered,
    isCorrect: optionIndex == question.correctAnswerIndex,
    selectedAnswers: currentAnswerState.selectedAnswers,
  );
}
