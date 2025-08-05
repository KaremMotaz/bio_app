import 'package:bio_app/features/lessons/domain/lesson_entity.dart';

class LessonModel extends LessonEntity {
  final int chapterId;

  LessonModel({
    required super.id,
    required super.title,
    required this.chapterId,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] as int,
      title: json['title'] as String,
      chapterId: json['chapterId'] as int,
    );
  }
}
