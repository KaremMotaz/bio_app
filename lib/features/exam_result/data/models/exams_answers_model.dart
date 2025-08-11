import 'package:cloud_firestore/cloud_firestore.dart';

class ExamsAnswersModel {
  final Map<String, int> answers;
  final Timestamp timestamp;
  final String id;

  ExamsAnswersModel({
    required this.answers,
    required this.timestamp,
    required this.id,
  });

  factory ExamsAnswersModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> answersMap = json['answers'] ?? {};
    final Map<String, int> answersParsed = answersMap.map(
      (key, value) => MapEntry(key, value as int),
    );

    return ExamsAnswersModel(
      answers: answersParsed,
      timestamp: json['timestamp'] as Timestamp,
      id: json['id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'answers': answers,
      'timestamp': timestamp.toDate().toIso8601String(),
      'id': id,
    };
  }
}
