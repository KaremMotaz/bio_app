class QuizProgressModel {
  final int currentQuestionIndex;
  final int answeredQuestionsCount;
  final int totalQuestions;

  QuizProgressModel({
    required this.currentQuestionIndex,
    required this.answeredQuestionsCount,
    required this.totalQuestions,
  });

  int get currentQuestionNumber => currentQuestionIndex + 1;

  bool get isLastQuestionFinished =>
      currentQuestionIndex == totalQuestions;

  double get progressPercentage => totalQuestions == 0
      ? 0
      : (answeredQuestionsCount / totalQuestions);
}

extension QuizProgressCopy on QuizProgressModel {
  QuizProgressModel copyWith({
    int? currentQuestionIndex,
    int? answeredQuestionsCount,
  }) {
    return QuizProgressModel(
      currentQuestionIndex:
          currentQuestionIndex ?? this.currentQuestionIndex,
      answeredQuestionsCount:
          answeredQuestionsCount ?? this.answeredQuestionsCount,
      totalQuestions: totalQuestions,
    );
  }
}
