class Question {
  final String id;
  final String text;
  final List<String> options;
  final int correctIndex;
  final String? imageUrl;
  final String type; // 'mcq', 'true_false', 'essay', 'order'
  final int marks;

  Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctIndex,
    required this.type,
    required this.marks,
    this.imageUrl,
  });
}