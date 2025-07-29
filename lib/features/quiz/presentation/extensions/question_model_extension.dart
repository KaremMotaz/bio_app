import '../../domain/entities/quiz_question_entity.dart';


extension QuestionModelExtension on QuizQuestionEntity {
  bool get hasScenario => scenario != null;

  bool get hasImages =>
      images != null && images!.isNotEmpty;

  String get fullQuestionText => hasScenario
      ? "$scenario\n- $questionText"
      : "- $questionText";
}
