import '../../domain/chapter_entity.dart';

class ChapterModel extends ChapterEntity {
  final int unitId;

  ChapterModel({
    required super.id,
    required super.title,
    required super.image,
    required super.colorIndex,
    required this.unitId,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return ChapterModel(
      id: json['id'] as int,
      title: json['title'] as String,
      image: json['image'] as String,
      colorIndex: json['colorIndex'] as int,
      unitId: json['unitId'] as int,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'colorIndex': colorIndex,
      'unitId': unitId,
    };
  }
}
