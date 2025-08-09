import '../../domain/quiz_entity.dart';

class QuizModel extends QuizEntity {
  QuizModel({
    required super.id,
    required super.index,
    required super.title,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      index: json['index'] as int,
      id: json['id'] as String,
      title: json['title'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'index': index, 'title': title};
  }
}
