import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/chapter_entity.dart';

class ChapterModel extends ChapterEntity {
  final String chapterId;
  final String unitId;

  ChapterModel({
    required super.id,
    required super.title,
    required super.image,
    required super.colorIndex,
    this.chapterId = '',
    this.unitId = '',
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return ChapterModel(
      id: json['id'] as int,
      title: json['title'] as String,
      image: json['image'] as String,
      colorIndex: json['colorIndex'] as int,
    );
  }
  factory ChapterModel.fromDocument(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return ChapterModel(
      chapterId: doc.id,
      id: data['index'] ?? 0,
      title: data['title'] ?? '',
      image: data['image'] ?? '',
      colorIndex: data['colorIndex'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'colorIndex': colorIndex,
    };
  }
}
