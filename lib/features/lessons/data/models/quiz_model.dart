import '../../domain/quiz_entity.dart';

class QuizModel extends QuizEntity {
  final int lessonId;

  QuizModel({
    required super.id,
    required super.title,
    required this.lessonId,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'] as int,
      title: json['title'] as String,
      lessonId: json['lessonId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'lessonId': lessonId,
    };
  }
}
