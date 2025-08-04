import 'package:bio_app/features/lessons/domain/lesson_entity.dart';

class LessonModel extends LessonEntity {
  LessonModel({
    required super.id,
    required super.number,
    required super.title,
    required super.topics,
    required super.colorList,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] as int,
      number: json['number'] as String,
      title: json['title'] as String,
      topics: List<String>.from(json['topics']),
      colorList: List<int>.from(json['colorList']),
    );
  }
}
