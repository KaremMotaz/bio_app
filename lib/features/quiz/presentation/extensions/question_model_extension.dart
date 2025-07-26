import '../../data/models/quiz_question_model.dart';

extension QuestionModelX on QuizQuestionModel {
  bool get hasScenario => scenario != null;

  bool get hasImages =>
      questionImages != null && questionImages!.isNotEmpty;

  String get fullQuestionText => hasScenario
      ? "$scenario\n- $questionText"
      : "- $questionText";
}
