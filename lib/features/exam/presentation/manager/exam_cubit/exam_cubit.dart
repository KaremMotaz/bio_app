import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/exam_entity.dart';
import '../../../domain/usecases/get_exam_usecase.dart';
import '../../../domain/usecases/submit_exam_usecase.dart';
part 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  final GetExamUseCase getExamUseCase;
  final SubmitExamUseCase submitExamUseCase;

  Timer? _timer;
  late DateTime _endTime;

  ExamCubit({
    required this.getExamUseCase,
    required this.submitExamUseCase,
  }) : super(ExamInitialState());

  Future<void> loadExam(String examId) async {
    emit(ExamLoadingState());

    try {
      final exam = await getExamUseCase(examId);
      _endTime = exam.endTime;

      emit(
        ExamRunningState(
          exam: exam,
          answers: {},
          remainingTimeInSeconds: _endTime.difference(DateTime.now()).inSeconds,
        ),
      );

      _startTimer();
    } catch (e) {
      emit(ExamErrorState(e.toString()));
    }
  }

  void _startTimer() {
    _tick(); // Immediate first tick
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    final now = DateTime.now();
    final remaining = _endTime.difference(now).inSeconds;

    final currentState = state;
    if (currentState is ExamRunningState) {
      if (remaining > 0) {
        emit(currentState.copyWith(remainingTimeInSeconds: remaining));
      } else {
        submitExam(); // Time is up
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
      final updatedAnswers = Map<String, int>.from(currentState.answers);
      updatedAnswers[questionId.toString()] = selectedIndex;

      emit(currentState.copyWith(answers: updatedAnswers));
    }
  }

  Future<void> submitExam() async {
    stopTimer();
    final currentState = state;
    if (currentState is ExamRunningState) {
      emit(ExamSubmittingState());

      try {
        await submitExamUseCase(currentState.exam.id, currentState.answers);
        emit(ExamSubmittedState());
      } catch (e) {
        emit(ExamErrorState(e.toString()));
      }
    }
  }
}
