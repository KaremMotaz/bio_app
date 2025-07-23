import 'package:bio_app/features/exam/domain/entities/exam.dart';
import 'package:bio_app/features/exam/domain/repos/exam_repo.dart';

class GetExamUseCase {
  final ExamRepo examRepo;
  GetExamUseCase({required this.examRepo});

  Future<Exam> call(String id) => examRepo.getExamById(id);
}