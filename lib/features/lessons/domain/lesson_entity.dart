class LessonEntity {
  final int id;
  final String number;
  final String title;
  final List<String> topics;
  final List<int> colorList;

  LessonEntity({
    required this.id,
    required this.number,
    required this.title,
    required this.colorList,
    required this.topics,
  });
}
