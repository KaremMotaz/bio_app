import 'package:json_annotation/json_annotation.dart';
import '../../domain/quiz_entity.dart';
part 'quiz_model.g.dart';

@JsonSerializable()
class QuizModel extends QuizEntity {
  QuizModel({
    required super.id,
    required super.index,
    required super.title,
    required super.lessonId,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return _$QuizModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$QuizModelToJson(this);
  }
}
