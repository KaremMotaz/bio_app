import 'package:cloud_firestore/cloud_firestore.dart';

class AnswersModel {
  final Map<String, int> answers;
  final Timestamp timestamp;
  final String id;

  AnswersModel({
    required this.answers,
    required this.timestamp,
    required this.id,
  });

  factory AnswersModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> answersMap = json['answers'] ?? {};
    final Map<String, int> answersParsed = answersMap.map(
      (key, value) => MapEntry(key, value as int),
    );

    return AnswersModel(
      answers: answersParsed,
      timestamp: json['timestamp'] as Timestamp,
      id: json['id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'answers': answers, 'timestamp': timestamp, 'id': id};
  }
}
