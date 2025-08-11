import 'dart:async';
import '../../../../../core/errors/failure.dart';
import '../../../data/repos/exam_questions_repo_impl.dart';
import '../../../domain/entities/exam_entity.dart';
import '../../../domain/entities/exam_question_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'exam_questions_state.dart';

class ExamQuestionsCubit extends Cubit<ExamQuestionsState> {
  final ExamQuestionsRepoImp examQuestionsRepoImpl;

  Timer? _timer;
  late DateTime _endTime;

  ExamQuestionsCubit({required this.examQuestionsRepoImpl})
    : super(ExamQuestionsInitialState());

  Future<void> getExamQuestions({
    required String examId,
    required int examIndex,
    required List<ExamEntity> exams,
  }) async {
    emit(ExamQuestionsLoadingState());

    final Either<Failure, List<ExamQuestionEntity>> result =
        await examQuestionsRepoImpl.getExamQuestions(examId: examId);

    result.fold(
      (failure) {
        emit(ExamQuestionsErrorState(message: failure.toString()));
      },
      (questions) {
        _endTime = exams[examIndex].endTime;

        emit(
          ExamQuestionsRunningState(
            examQuestions: questions,
            answers: {},
            remainingTimeInSeconds: _endTime
                .difference(DateTime.now())
                .inSeconds,
            exams: exams,
          ),
        );

        _startTimer(examId: examId);
      },
    );
  }

  void _startTimer({required String examId}) {
    _tick(examId: examId); // Immediate first tick
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _tick(examId: examId),
    );
  }

  void _tick({required String examId}) {
    final now = DateTime.now();
    final remaining = _endTime.difference(now).inSeconds;

    final currentState = state;
    if (currentState is ExamQuestionsRunningState) {
      if (remaining > 0) {
        emit(
          currentState.copyWith(
            remainingTimeInSeconds: remaining,
            exams: [],
          ),
        );
      } else {
        submitExam(examId: examId); // Time is up
      }
    }
  }

  void stopTimer() {
    _timer?.cancel();
  }

  @override
  Future<void> close() {
    stopTimer();
    return super.close();
  }

  void selectAnswer(int questionId, int selectedIndex) {
    final currentState = state;
    if (currentState is ExamQuestionsRunningState) {
      final updatedAnswers = Map<String, int>.from(
        currentState.answers,
      );
      updatedAnswers[questionId.toString()] = selectedIndex;

      emit(currentState.copyWith(answers: updatedAnswers, exams: []));
    }
  }

  Future<void> submitExam({required String examId}) async {
    stopTimer();
    final currentState = state;

    if (currentState is ExamQuestionsRunningState) {
      emit(ExamQuestionsSubmittingState());

      final result = await examQuestionsRepoImpl.submitAnswers(
        examId: examId,
        answers: currentState.answers,
      );

      result.fold(
        (failure) => emit(
          ExamQuestionsErrorState(message: failure.toString()),
        ),
        (_) => emit(ExamQuestionsSubmittedState()),
      );
    }
  }
}
