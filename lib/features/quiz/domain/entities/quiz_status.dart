class QuizStatus {
  final int score;
  final int remainingLives;

  QuizStatus({
    required this.score,
    required this.remainingLives,
  });

  QuizStatus copyWith({
    int? score,
    int? remainingLives,
  }) {
    return QuizStatus(
      score: score ?? this.score,
      remainingLives: remainingLives ?? this.remainingLives,
    );
  }
}
