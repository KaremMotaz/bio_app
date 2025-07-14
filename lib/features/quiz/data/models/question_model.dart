class QuestionModel {
  final String? questionScenario;
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final String? explanation;
  final List<String>? questionImages;
  final QuestionType questionType;

  QuestionModel({
    this.questionScenario,
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    this.explanation,
    this.questionImages,
    required this.questionType,
  });
}

enum QuestionType { textChoices, imageChoices, trueFalse }
