import '../../domain/lesson_entity.dart';

class LessonModel extends LessonEntity {
  LessonModel({required super.id, required super.title});

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] as String,
      title: json['title'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title};
  }
}
