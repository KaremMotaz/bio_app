import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/failure.dart';
import '../../../data/models/question_model.dart';
import '../../../domain/logic/answer_evaluator.dart';
import '../../../domain/entities/quiz_progress.dart';
import '../../../domain/entities/quiz_result.dart';
import '../../../domain/entities/quiz_status.dart';
import '../../../domain/logic/quiz_timer.dart';
import '../../../domain/repos/questions_repo.dart';
import '../../extensions/quiz_loaded_state_extension.dart';

part 'quiz_state.dart';
part 'quiz_answer_state.dart';

class QuizCubit extends Cubit<QuizState> {
  final QuestionsRepo questionsRepo;
  final QuizTimer _timer;
  final AnswerEvaluator _evaluator;

  QuizCubit(this._timer, this._evaluator, {required this.questionsRepo})
    : super(QuizInitialState());

  Future<void> loadQuestions() async {
    emit(QuizLoadingState());
    final Either<Failure, List<QuestionModel>> questions = questionsRepo
        .getQuestions();
    questions.fold(
      (failure) => emit(QuizErrorState(message: failure.errMessage)),
      (questions) {
        _timer.start();
        emit(
          QuizLoadedState(
            questions: questions,
            status: QuizStatus(score: 0, remainingLives: 5),
            answerState: QuizAnswerState(
              isSelected: false,
              selectedAnswers: {},
            ),
            progress: QuizProgress(
              currentQuestionIndex: 0,
              answeredQuestionsCount: 0,
              totalQuestions: questions.length,
            ),
          ),
        );
      },
    );
  }

  void checkAnswer() {
    final currentState = state as QuizLoadedState;

    final bool isCorrect = _evaluator.isCorrectAnswer(
      currentState.currentQuestion,
      currentState.currentSelectedAnswerIndex,
    );

    final int newRemainingLives = _evaluator.updateRemainingLives(
      isCorrect,
      currentState.remainingLives,
    );

    emit(
      currentState.copyWith(
        status: currentState.status.copyWith(
          score: isCorrect
              ? currentState.status.score + 1
              : currentState.status.score,
          remainingLives: newRemainingLives,
        ),
        answerState: currentState.answerState.copyWith(
          isSelected: true,
          isCorrect: isCorrect,
          isAnswered: true,
          isLastLifeLost: !isCorrect && newRemainingLives == 0,
        ),
      ),
    );
  }

  void nextQuestion() {
    final currentState = state as QuizLoadedState;

    final QuizProgress newProgress = currentState.progress.copyWith(
      currentQuestionIndex: currentState.currentQuestionIndex + 1,
      answeredQuestionsCount: currentState.answeredQuestionsCount + 1,
    );

    if (!newProgress.isLastQuestionFinished) {
      emit(
        currentState.copyWith(
          progress: newProgress,
          answerState: currentState.answerState.copyWith(
            isSelected: false,
            selectedAnswers: currentState.answerState.selectedAnswers,
            isCorrect: null,
            isAnswered: false,
          ),
        ),
      );
    } else {
      emit(
        QuizFinishedState(
          result: QuizResult(
            finalScore: currentState.status.score,
            totalQuestions: currentState.totalQuestions,
            duration: _timer.calculateDuration(),
          ),
        ),
      );
    }
  }

  void selectAnswer(int index) {
    final currentState = state as QuizLoadedState;

    emit(
      currentState.copyWith(
        answerState: currentState.answerState.copyWith(
          selectedAnswers: currentState.updateAnswerAt(index),
          isSelected: true,
        ),
      ),
    );
  }

  void finishQuizIfLastLifeLost() {
    final currentState = state as QuizLoadedState;

    emit(
      QuizFinishedState(
        result: QuizResult(
          finalScore: currentState.status.score,
          totalQuestions: currentState.totalQuestions,
          duration: _timer.calculateDuration(),
        ),
      ),
    );
  }

  void exitToHome() {
    emit(QuizExitToHomeState());
  }
}
