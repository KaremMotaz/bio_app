import 'package:bio_app/features/exam/domain/entities/exam_result.dart';
import 'package:bio_app/features/exam/domain/repos/exam_repo.dart';


class SubmitExamUseCase {
  final ExamRepo examRepo;
  SubmitExamUseCase({required this.examRepo});

  Future<ExamResultEntity> call(String examId, Map<String, dynamic> answers) {
    return examRepo.submitAnswers(examId, answers);
  }
}
