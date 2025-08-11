import 'package:bio_app/features/exam/domain/entities/exam_question_entity.dart';
import 'package:bio_app/features/exam/domain/repos/exam_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/services/exam_grading_service.dart';
import '../../../domin/repos/exam_result_repo.dart';
part 'exam_result_state.dart';

class ExamResultCubit extends Cubit<ExamResultState> {
  final ExamResultRepo examResultRepo;
  final ExamRepo examRepo;

  ExamResultCubit({
    required this.examResultRepo,
    required this.examRepo,
  }) : super(ExamResultInitialState());

  void getResult({
    required String examId,
    required int resultExamIndex,
  }) async {
    emit(ExamResultLoadingState());

    final examQuestionsEither = await examResultRepo.getExamQuestions(
      examId: examId,
    );
    examQuestionsEither.fold(
      (failure) {
        emit(ExamResultErrorState(message: failure.toString()));
      },
      (examQuestions) async {
        final examsEither = await examRepo.getExams();
        examsEither.fold(
          (failure) {
            emit(ExamResultErrorState(message: failure.toString()));
          },
          (exams) async {
            final answersEither = await examResultRepo
                .getStudentAnswers();
            answersEither.fold(
              (failure) {
                emit(
                  ExamResultErrorState(message: failure.toString()),
                );
              },
              (studentAnswers) {
                final studentScore =
                    ExamGradingService.calculateStudentScore(
                      examQuestions: examQuestions,
                      studentAnswers:
                          studentAnswers[resultExamIndex].answers,
                    );
                final maxScore = ExamGradingService.calculateMaxScore(
                  examQuestions: examQuestions,
                );
                final double studentPercentage =
                    ExamGradingService.calculatePercentage(
                      studentScore: studentScore,
                      maxScore: maxScore,
                    );
                final bool passed = ExamGradingService.isPassed(
                  studentPercentage: studentPercentage,
                  passPercentage:
                      exams[resultExamIndex].passPercentage,
                );

                emit(
                  ExamResultLoadedState(
                    examQuestions: examQuestions,
                    studentScore: studentScore,
                    maxScore: maxScore,
                    percentage: studentPercentage,
                    isPassed: passed,
                    answers: studentAnswers[resultExamIndex].answers,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
