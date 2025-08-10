import 'package:bio_app/features/exam/domain/entities/exam_question_entity.dart';
import '../repos/exam_repo.dart';

class GetExamUseCase {
  final ExamRepo examRepo;
  GetExamUseCase({required this.examRepo});

  Future<ExamQuestionEntity> call(String id) =>
      examRepo.getExamById(id);
}
