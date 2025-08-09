import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/lesson_entity.dart';

class LessonModel extends LessonEntity {
  final String chapterId;
  final String unitId;

  LessonModel({
    required super.id,
    required super.title,
    required this.chapterId,
    required this.unitId,
    super.lessonId = '',
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] as int,
      title: json['title'] as String,
      chapterId: json['chapterId'] as String,
      unitId: json['unitId'] as String,
    );
  }

  factory LessonModel.fromDocument(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return LessonModel(
      lessonId: doc.id,
      id: data['index'] ?? 0,
      title: data['title'] ?? '',
      chapterId: data['chapterId'] ?? 0,
      unitId: data['unitId'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'chapterId': chapterId,
      'unitId': unitId,
    };
  }
}
