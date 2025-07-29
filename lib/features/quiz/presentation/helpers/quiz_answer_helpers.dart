import 'package:bio_app/features/quiz/domain/entities/quiz_question_entity.dart';
import '../manager/quiz_cubit/quiz_cubit.dart';

QuizAnswerState getAnswerStateForOption({
  required QuizQuestionEntity question,
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
