import '../../domain/quiz_entity.dart';

class QuizModel extends QuizEntity {
  QuizModel({
    required super.id,
    required super.index,
    required super.title,
    required super.lessonId,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'] as String,
      index: json['index'] as int,
      title: json['title'] as String,
      lessonId: json['lessonId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'index': index,
      'title': title,
      'lessonId': lessonId,
    };
  }
}
