class ExamEntity {
  final String id;
  final String title;
  final String unit;
  final String lesson;
  final DateTime endTime;
  final DateTime startTime;
  final double passPercentage;
  final bool isPublished;
  final bool isResultPublished;

  ExamEntity({
    required this.id,
    required this.title,
    required this.unit,
    required this.lesson,
    required this.startTime,
    required this.endTime,
    required this.passPercentage,
    required this.isPublished,
    required this.isResultPublished,
  });
}
