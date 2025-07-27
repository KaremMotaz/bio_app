import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_exam_usecase.dart';
import '../../../domain/usecases/submit_exam_usecase.dart';
import '../../../domain/entities/exam_entity.dart';

part 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  final GetExamUseCase getExamUseCase;
  final SubmitExamUseCase submitExamUseCase;

  ExamCubit({
    required this.getExamUseCase,
    required this.submitExamUseCase,
  }) : super(ExamInitialState());

  ExamEntity? currentExam;
  Map<String, int> answers =
      {}; // questionId -> selectedIndex
  int currentPageIndex = 0;

  Future<void> loadExam(String examId) async {
    emit(ExamLoadingState());
    final exam = await getExamUseCase(examId);
    currentExam = exam;
    emit(ExamLoadedState(exam));
  }

  void selectAnswer(int questionId, int selectedIndex) {
    answers[questionId.toString()] = selectedIndex;
    emit(AnswerSelectedState(questionId, selectedIndex));
  }

  void goToNextPage() {
    if (currentPageIndex <
        currentExam!.questions.length - 1) {
      currentPageIndex++;
      emit(PageChangedState(currentPageIndex));
    }
  }

  void goToPreviousPage() {
    if (currentPageIndex > 0) {
      currentPageIndex--;
      emit(PageChangedState(currentPageIndex));
    }
  }

  Future<void> submitExam() async {
    emit(ExamSubmittingState());

    try {
      final result = await submitExamUseCase(
        currentExam!.id,
        answers,
      );
      emit(ExamSubmittedState());
      return result;
    } catch (e) {
      emit(ExamErrorState(e.toString()));
    }
  }
}
