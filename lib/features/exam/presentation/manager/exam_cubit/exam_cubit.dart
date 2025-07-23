import 'package:bio_app/features/exam/domain/entities/exam_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bio_app/features/exam/domain/usecases/get_exam_usecase.dart';
import 'package:bio_app/features/exam/domain/usecases/submit_exam_usecase.dart';
import 'package:bio_app/features/exam/domain/entities/exam.dart';

part 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  final GetExamUseCase getExamUseCase;
  final SubmitExamUseCase submitExamUseCase;

  ExamCubit({
    required this.getExamUseCase,
    required this.submitExamUseCase,
  }) : super(ExamInitial());

  Exam? currentExam;
  Map<String, int> answers = {}; // questionId -> selectedIndex

  Future<void> loadExam(String examId) async {
    emit(ExamLoading());
    final exam = await getExamUseCase(examId);
    currentExam = exam;
    emit(ExamLoaded(exam));
  }

  void selectAnswer(String questionId, int selectedIndex) {
    answers[questionId] = selectedIndex;
    emit(AnswerSelected(questionId, selectedIndex));
  }

Future<ExamResultEntity?> submitExam() async {
  if (currentExam == null) return null;
  emit(ExamSubmitting());

  try {
    final result = await submitExamUseCase(currentExam!.id, answers);
    emit(ExamSubmitted(result));
    return result;
  } catch (e) {
    emit(ExamError(e.toString()));
    return null;
  }
}
}
