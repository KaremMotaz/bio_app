import 'package:bio_app/features/quiz_questions/domain/entities/quiz_question_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/failure.dart';
import '../../../data/models/quiz_question_model.dart';
import '../../../data/models/quiz_progress_model.dart';
import '../../../data/models/quiz_result_model.dart';
import '../../../data/models/quiz_status_model.dart';
import '../../../domain/helper/quiz_loaded_state_extension.dart';
import '../../../domain/helper/quiz_helpers.dart';
import '../../../domain/repos/quiz_questions_repo.dart';
part '../../../data/models/quiz_question_answer_model.dart';
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

  Future<void> loadQuestions({required String quizId}) async {
    emit(QuizQuestionsLoadingState());

    final Either<Failure, List<QuizQuestionModel>> quizQuestions =
        await questionsRepo.getQuizQuestions(quizId: quizId);

    quizQuestions.fold(
      (failure) =>
          emit(QuizQuestionsErrorState(message: failure.message)),
      (questions) {
        _timer.startTimer();
        emit(
          QuizQuestionsLoadedState(
            questions: questions,
            status: QuizStatusModel(score: 0, remainingLives: 5),
            answerState: const QuizQuestionAnswerModel(
              isSelected: false,
              selectedAnswers: {},
            ),
            progress: QuizProgressModel(
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
              ? currentState.status.score +
                    (currentState.currentQuestion.marks ?? 1)
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

  Future<void> nextQuestion() async {
    final currentState = state as QuizQuestionsLoadedState;

    final QuizProgressModel newProgress = currentState.progress
        .copyWith(
          currentQuestionIndex: currentState.currentQuestionIndex + 1,
          answeredQuestionsCount:
              currentState.answeredQuestionsCount + 1,
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
      final int totalMaxScore = currentState.questions.fold(
        0,
        (sum, question) => sum + (question.marks ?? 1),
      );

      emit(
        QuizQuestionsFinishedState(
          result: QuizResultModel(
            finalScore: currentState.status.score,
            totalMaxScore: totalMaxScore,
            duration: _timer.getDuration(),
          ),
        ),
      );
      await questionsRepo.uploadQuizScoreToLeaderboards(
        score: currentState.status.score,
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

    final totalMaxScore = currentState.questions.fold(
      0,
      (sum, question) => sum + (question.marks ?? 1),
    );

    emit(
      QuizQuestionsFinishedState(
        result: QuizResultModel(
          finalScore: currentState.status.score,
          totalMaxScore: totalMaxScore,
          duration: _timer.getDuration(),
        ),
      ),
    );
  }

  void exitToHome() {
    emit(QuizQuestionsExitToHomeState());
  }
}
