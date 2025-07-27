import '../repos/exam_repo.dart';

class SubmitExamUseCase {
  final ExamRepo examRepo;
  SubmitExamUseCase({required this.examRepo});

  Future<void> call(
    String examId,
    Map<String, dynamic> answers,
  ) {
    examRepo.submitAnswers(examId, answers);
    return Future.value();}
}
