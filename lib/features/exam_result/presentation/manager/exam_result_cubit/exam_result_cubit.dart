import 'package:bio_app/features/exam/domain/entities/exam_entity.dart';
import 'package:bio_app/features/exam/domain/usecases/get_exam_usecase.dart';
import 'package:bio_app/features/exam_result/data/services/exam_grading_service.dart';
import 'package:bio_app/features/exam_result/domin/repos/exam_result_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'exam_result_state.dart';

class ExamResultCubit extends Cubit<ExamResultState> {
  final GetExamUseCase getExamUseCase;
  final ExamResultRepo examResultRepo;

  ExamResultCubit({
    required this.examResultRepo,
    required this.getExamUseCase,
  }) : super(ExamResultInitialState());

  void getResult({required int examId}) async {
    emit(ExamResultLoadingState());

    final ExamEntity exam = await getExamUseCase(examId.toString());

    final Map<String, int> studentAnswers = await examResultRepo
        .getStudentAnswers(examId.toString());
    try {
      final int studentScore =
          ExamGradingService.calculateStudentScore(
            exam,
            studentAnswers,
          );
      final int maxScore = ExamGradingService.calculateMaxScore(exam);
      final double percentage =
          ExamGradingService.calculatePercentage(
            studentScore,
            maxScore,
          );
      final bool passed = ExamGradingService.isPassed(
        studentScore,
        exam.passMark,
      );

      emit(
        ExamResultLoadedState(
          exam: exam,
          studentScore: studentScore,
          maxScore: maxScore,
          percentage: percentage,
          passed: passed,
        ),
      );
    } catch (e) {
      emit(
        const ExamResultErrorState(
          message: 'حدث خطأ أثناء حساب النتيجة',
        ),
      );
    }
  }
}
