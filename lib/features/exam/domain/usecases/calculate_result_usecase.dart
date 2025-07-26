import 'package:bio_app/features/exam/domain/entities/exam_entity.dart';

class CalculateResultUseCase {
  int call(ExamEntity exam, Map<String, dynamic> answers) {
    int score = 0;
    for (var question in exam.questions) {
      if (question.type == 'mcq' ||
          question.type == 'true_false') {
        if (answers[question.id.toString()] ==
            question.correctIndex) {
          score += question.marks;
        }
      }
    }
    return score;
  }
}
