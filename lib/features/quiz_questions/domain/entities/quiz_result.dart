
class QuizResult {
  final double finalScore;
  final int totalMaxScore;
  final Duration duration;

  QuizResult({
    required this.finalScore,
    required this.totalMaxScore,
    required this.duration,
  });



  int get accuracy => ((finalScore / totalMaxScore) * 100).round();

  String get formattedDuration {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }
}
