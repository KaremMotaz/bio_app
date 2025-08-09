import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/quiz_entity.dart';

class QuizModel extends QuizEntity {
  final int lessonId;

  QuizModel({
    required super.id,
    super.quizId = '',
    required super.title,
    required this.lessonId,
  });

  factory QuizModel.fromDocument(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return QuizModel(
      quizId: doc.id,
      id: data['index'] ?? 0,
      title: data['title'] ?? '',
      lessonId: data['lessonId'] ?? 0,
    );
  }

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'] as int,
      title: json['title'] as String,
      lessonId: json['lessonId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'lessonId': lessonId};
  }
}
