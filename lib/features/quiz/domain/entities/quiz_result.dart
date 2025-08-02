
class QuizResult {
  final int finalScore;
  final int totalQuestions;
  final Duration duration;

  QuizResult({
    required this.finalScore,
    required this.totalQuestions,
    required this.duration,
  });

  int get accuracy => ((finalScore / totalQuestions) * 100).round();

  String get formattedDuration {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }
}
