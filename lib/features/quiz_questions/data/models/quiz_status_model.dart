class QuizStatusModel {
  final double score;
  final int remainingLives;

  QuizStatusModel({
    required this.score,
    required this.remainingLives,
  });

  QuizStatusModel copyWith({double? score, int? remainingLives}) {
    return QuizStatusModel(
      score: score ?? this.score,
      remainingLives: remainingLives ?? this.remainingLives,
    );
  }
}
