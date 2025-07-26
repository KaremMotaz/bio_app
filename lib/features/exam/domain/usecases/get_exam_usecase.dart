import 'package:bio_app/features/exam/domain/entities/exam_entity.dart';
import 'package:bio_app/features/exam/domain/repos/exam_repo.dart';

class GetExamUseCase {
  final ExamRepo examRepo;
  GetExamUseCase({required this.examRepo});

  Future<ExamEntity> call(String id) =>
      examRepo.getExamById(id);
}
