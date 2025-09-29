import 'package:json_annotation/json_annotation.dart';

import '../../domain/chapter_entity.dart';

part 'chapter_model.g.dart';

@JsonSerializable()
class ChapterModel extends ChapterEntity {
  ChapterModel({
    required super.id,
    required super.index,
    required super.title,
    required super.image,
    required super.colorIndex,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return _$ChapterModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ChapterModelToJson(this);
  }
}
