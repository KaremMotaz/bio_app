class QuizQuestionModel {
  final String? scenario;
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final String? explanation;
  final List<String>? questionImages;
  final QuizQuestionType type;

  QuizQuestionModel({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    this.scenario,
    this.explanation,
    this.questionImages,
    required this.type,
  });

  static fromMap(Map<String, dynamic> q) {}
}

enum QuizQuestionType {
  textChoices,
  imageChoices,
  trueFalse,
}
