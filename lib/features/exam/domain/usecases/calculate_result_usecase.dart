import '../../../../core/models/exam_question_model.dart';
import '../entities/exam_entity.dart';

class CalculateResultUseCase {
  int call(ExamEntity exam, Map<String, dynamic> answers) {
    int score = 0;

    for (var question in exam.questions) {
      if (question.type == ExamOptionsType.textOptions ||
          question.type ==
              ExamOptionsType.trueFalseOptions) {
        if (answers[question.id.toString()] ==
            question.correctIndex) {
          score += question.marks;
        }
      }
    }
    return score;
  }
}
