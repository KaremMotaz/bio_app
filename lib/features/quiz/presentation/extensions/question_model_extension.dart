import 'package:bio_app/features/quiz/data/models/question_model.dart';

extension QuestionModelX on QuestionModel {
  bool get hasScenario => questionScenario != null;

  bool get hasImages => questionImages != null && questionImages!.isNotEmpty;

  String get fullQuestionText =>
      hasScenario ? "$questionScenario\n- $questionText" : "- $questionText";
}
