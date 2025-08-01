import '../../../../core/entities/base_question_entity.dart';
import '../manager/quiz_cubit/quiz_cubit.dart';

QuizAnswerState getAnswerStateForOption({
  required BaseQuestionEntity question,
  required int selectedIndex,
  required int optionIndex,
  required QuizAnswerState currentAnswerState,
}) {
  return QuizAnswerState(
    isSelected: selectedIndex == optionIndex,
    isAnswered: currentAnswerState.isAnswered,
    isCorrect: optionIndex == question.correctIndex,
    selectedAnswers: currentAnswerState.selectedAnswers,
  );
}
