import 'package:bio_app/features/exam/domain/entities/exam_question_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../exam/domain/entities/exam_entity.dart';
import '../../../../exam/domain/usecases/get_exam_usecase.dart';
import '../../../data/services/exam_grading_service.dart';
import '../../../domin/repos/exam_result_repo.dart';

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

    final List<ExamQuestionEntity> examQuestions =
        await getExamUseCase(examId.toString());
    final ExamEntity exam = await getExamUseCase(examId.toString());

    final Map<String, int> studentAnswers = await examResultRepo
        .getStudentAnswers(examId.toString());
    try {
      final int studentScore =
          ExamGradingService.calculateStudentScore(
            examQuestions: examQuestions,
            studentAnswers: studentAnswers,
          );
      final int maxScore = ExamGradingService.calculateMaxScore(
        examQuestions: examQuestions,
      );
      final double studentPercentage =
          ExamGradingService.calculatePercentage(
            studentScore: studentScore,
            maxScore: maxScore,
          );
      final bool passed = ExamGradingService.isPassed(
        studentPercentage: studentPercentage,
        passPercentage: exam.passPercentage,
      );

      emit(
        ExamResultLoadedState(
          examQuestions: examQuestions,
          studentScore: studentScore,
          maxScore: maxScore,
          percentage: studentPercentage,
          isPassed: passed,
          answers: studentAnswers,
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
