class QuizStatus {
  final double score;
  final int remainingLives;

  QuizStatus({
    required this.score,
    required this.remainingLives,
  });

  QuizStatus copyWith({
    double? score,
    int? remainingLives,
  }) {
    return QuizStatus(
      score: score ?? this.score,
      remainingLives: remainingLives ?? this.remainingLives,
    );
  }
}
