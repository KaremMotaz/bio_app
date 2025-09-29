import 'package:json_annotation/json_annotation.dart';

import '../../domain/lesson_entity.dart';
part 'lesson_model.g.dart';

@JsonSerializable()
class LessonModel extends LessonEntity {
  LessonModel({required super.id, required super.title});

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return _$LessonModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LessonModelToJson(this);
  }
}
