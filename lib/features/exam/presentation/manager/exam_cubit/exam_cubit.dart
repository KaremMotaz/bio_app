import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_exam_usecase.dart';
import '../../../domain/usecases/submit_exam_usecase.dart';
import '../../../domain/entities/exam_entity.dart';
part 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  final GetExamUseCase getExamUseCase;
  final SubmitExamUseCase submitExamUseCase;
  int currentPageIndex = 0;
  ExamEntity? currentExam;
  Map<String, int> answers = {};

  bool get isQuestionAnswered {
    if (currentExam == null) return false;
    final questionId = currentExam!
        .questions[currentPageIndex]
        .id
        .toString();
    return answers.containsKey(questionId);
  }

  Timer? _timer;
  late DateTime endTime;

  ExamCubit({
    required this.getExamUseCase,
    required this.submitExamUseCase,
  }) : super(ExamInitialState());

  Future<void> loadExam(String examId) async {
    emit(ExamLoadingState());
    final exam = await getExamUseCase(examId);
    currentExam = exam;
    emit(ExamLoadedState(exam));
    startFixedExamTimer(exam.endTime);
  }

  void startFixedExamTimer(DateTime endTimeFromServer) {
    endTime = endTimeFromServer;

    _tick(); // call first tick immediately

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _tick(),
    );
  }

  void _tick() {
    final DateTime now = DateTime.now();
    final int remaining = endTime.difference(now).inSeconds;

    if (remaining > 0) {
      emit(ExamRunningState(remaining));
    } else {
      submitExam();
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
    answers[questionId.toString()] = selectedIndex;
    emit(AnswerSelectedState(questionId, selectedIndex));
  }

  void jumpToQuestion({
    required int index,
    required pageController,
  }) {
    pageController.jumpToPage(index);
    currentPageIndex = index;
    emit(PageChangedState(pageIndex: index));
  }

  void goToNextPage() {
    if (currentPageIndex <
        currentExam!.questions.length - 1) {
      currentPageIndex++;
      emit(PageChangedState(pageIndex: currentPageIndex));
    }
  }

  void goToPreviousPage() {
    if (currentPageIndex > 0) {
      currentPageIndex--;
      emit(PageChangedState(pageIndex: currentPageIndex));
    }
  }

  Future<void> submitExam() async {
    stopTimer();
    emit(ExamSubmittingState());
    try {
      await submitExamUseCase(currentExam!.id, answers);
      emit(ExamSubmittedState());
    } catch (e) {
      emit(ExamErrorState(e.toString()));
    }
  }
}
