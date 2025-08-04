import 'package:bio_app/features/chapters/domain/chapter_entity.dart';

class ChapterModel extends ChapterEntity {
  ChapterModel({
    required super.id,
    required super.number,
    required super.title,
    required super.image,
    required super.colorList,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return ChapterModel(
      id: json['id'] as int,
      number: json['number'] as String,
      title: json['title'] as String,
      image: json['image'] as String,
      colorList: List<int>.from(json['colorList']),
    );
  }
}
