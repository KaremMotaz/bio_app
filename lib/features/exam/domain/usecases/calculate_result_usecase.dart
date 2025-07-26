import 'package:bio_app/features/exam/data/models/question_exam_model.dart';
import 'package:bio_app/features/exam/domain/entities/exam_entity.dart';

class CalculateResultUseCase {
  int call(ExamEntity exam, Map<String, dynamic> answers) {
    int score = 0;

    for (var question in exam.questions) {
      if (question.type == ExamQuestionType.textChoices ||
          question.type == ExamQuestionType.trueFalse) {
        if (answers[question.id.toString()] ==
            question.correctIndex) {
          score += question.marks;
        }
      }
    }
    return score;
  }
}
