class Question {
  final String id;
  final String? scenario;
  final String text;
  final List<String> options;
  final int correctIndex;
  final List<String>? imageUrl;
  final String type; // 'mcq', 'true_false', 'essay', 'order'
  final int marks;

  Question({
    required this.id,
    this.scenario, 
    required this.text,
    required this.options,
    required this.correctIndex,
    required this.type,
    required this.marks,
    this.imageUrl,
  });
}