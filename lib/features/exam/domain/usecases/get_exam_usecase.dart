import '../entities/exam_entity.dart';
import '../repos/exam_repo.dart';

class GetExamUseCase {
  final ExamRepo examRepo;
  GetExamUseCase({required this.examRepo});

  Future<ExamEntity> call(String id) =>
      examRepo.getExamById(id);
}
