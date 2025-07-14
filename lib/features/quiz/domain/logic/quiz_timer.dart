class QuizTimer {
  DateTime? _startTime;

  void start() {
    _startTime = DateTime.now();
  }

  Duration calculateDuration() {
    if (_startTime == null) return Duration.zero;
    return DateTime.now().difference(_startTime!);
  }
}
