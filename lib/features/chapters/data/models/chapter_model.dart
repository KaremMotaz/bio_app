import '../../domain/chapter_entity.dart';

class ChapterModel extends ChapterEntity {

  ChapterModel({
    required super.id,
    required super.index,
    required super.title,
    required super.image,
    required super.colorIndex,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return ChapterModel(
      id: json['id'] as String,
      index: json['index'] as int,
      title: json['title'] as String,
      image: json['image'] as String,
      colorIndex: json['colorIndex'] as int,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'title': title,
      'image': image,
      'colorIndex': colorIndex,
    };
  }
}
