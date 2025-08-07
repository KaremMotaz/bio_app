import 'package:bio_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/quiz_question_model.dart';
import '../../../domain/entities/quiz_progress.dart';
import '../../../domain/entities/quiz_result.dart';
import '../../../domain/entities/quiz_status.dart';
import '../../../domain/extensions/quiz_loaded_state_extension.dart';
import '../../../domain/logic/quiz_helpers.dart';
import '../../../domain/repos/quiz_questions_repo.dart';

part 'quiz_answer_state.dart';
part 'quiz_questions_state.dart';

class QuizQuestionsCubit extends Cubit<QuizQuestionsState> {
  final QuizQuestionsRepo questionsRepo;
  final QuizHelper _timer;
  final QuizHelper _evaluator;

  QuizQuestionsCubit(
    this._timer,
    this._evaluator, {
    required this.questionsRepo,
  }) : super(QuizQuestionsInitialState());

  Future<void> loadQuestions({required int quizId}) async {
    emit(QuizQuestionsLoadingState());

    final Either<Failure, List<QuizQuestionModel>> quizQuestions =
        await questionsRepo.getQuizQuestions(quizId: quizId);

    quizQuestions.fold(
      (failure) =>
          emit(QuizQuestionsErrorState(message: failure.errMessage)),
      (questions) {
        _timer.startTimer();
        emit(
          QuizQuestionsLoadedState(
            questions: questions,
            status: QuizStatus(score: 0, remainingLives: 5),
            answerState: const QuizAnswerState(
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
    final currentState = state as QuizQuestionsLoadedState;

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
    final currentState = state as QuizQuestionsLoadedState;

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
        QuizQuestionsFinishedState(
          result: QuizResult(
            finalScore: currentState.status.score,
            totalQuestions: currentState.totalQuestions,
            duration: _timer.getDuration(),
          ),
        ),
      );
    }
  }

  void selectAnswer(int index) {
    final currentState = state as QuizQuestionsLoadedState;

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
    final currentState = state as QuizQuestionsLoadedState;

    emit(
      QuizQuestionsFinishedState(
        result: QuizResult(
          finalScore: currentState.status.score,
          totalQuestions: currentState.totalQuestions,
          duration: _timer.getDuration(),
        ),
      ),
    );
  }

  void exitToHome() {
    emit(QuizQuestionsExitToHomeState());
  }
}
