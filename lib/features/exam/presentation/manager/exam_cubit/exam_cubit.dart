import 'dart:async';
import 'package:bio_app/core/errors/failure.dart';
import 'package:bio_app/features/exam/data/repos/exam_repo_impl.dart';
import 'package:bio_app/features/exam/domain/entities/exam_entity.dart';
import 'package:bio_app/features/exam/domain/entities/exam_question_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  final ExamRepoImpl examRepoImpl;

  Timer? _timer;
  late DateTime _endTime;

  ExamCubit({required this.examRepoImpl}) : super(ExamInitialState());

  Future<void> getExams({
    required String examId,
    required int examIndex,
  }) async {
    emit(ExamLoadingState());

    final Either<Failure, List<ExamEntity>> eitherExam =
        await examRepoImpl.getExams();

    await eitherExam.fold(
      (failure) {
        emit(ExamErrorState(failure.toString()));
        return;
      },
      (exam) async {
        final eitherQuestions = await examRepoImpl.getExamQuestions(
          examId: examId,
        );

        eitherQuestions.fold(
          (failure) {
            emit(ExamErrorState(failure.toString()));
          },
          (questions) {
            _endTime = exam[examIndex].endTime;

            emit(
              ExamRunningState(
                examQuestions: questions,
                answers: {},
                remainingTimeInSeconds: _endTime
                    .difference(DateTime.now())
                    .inSeconds,
                exam: exam[examIndex],
              ),
            );

            _startTimer(examId: examId);
          },
        );
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
    if (currentState is ExamRunningState) {
      if (remaining > 0) {
        emit(
          currentState.copyWith(remainingTimeInSeconds: remaining),
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
    if (currentState is ExamRunningState) {
      final updatedAnswers = Map<String, int>.from(
        currentState.answers,
      );
      updatedAnswers[questionId.toString()] = selectedIndex;

      emit(currentState.copyWith(answers: updatedAnswers));
    }
  }

  Future<void> submitExam({required String examId}) async {
    stopTimer();
    final currentState = state;
    if (currentState is ExamRunningState) {
      emit(ExamSubmittingState());

      try {
        
        await examRepoImpl.submitAnswers(
          examId: examId,
          answers: currentState.answers,
        );

        emit(ExamSubmittedState());
      } catch (e) {
        emit(ExamErrorState(e.toString()));
      }
    }
  }
}
