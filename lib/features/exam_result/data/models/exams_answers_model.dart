import 'package:cloud_firestore/cloud_firestore.dart';

class ExamsAnswersModel {
  final Map<String, int> answers;
  final DateTime dateTime;
  final String id;

  ExamsAnswersModel({
    required this.answers,
    required this.dateTime,
    required this.id,
  });

  // ========== Firestore ==========
  factory ExamsAnswersModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> answersMap = json['answers'] ?? {};
    final Map<String, int> answersParsed = answersMap.map(
      (key, value) => MapEntry(key, value as int),
    );

    return ExamsAnswersModel(
      answers: answersParsed,
      dateTime: (json['timestamp'] as Timestamp).toDate(),
      id: json['id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'answers': answers,
      'timestamp': Timestamp.fromDate(dateTime),
      'id': id,
    };
  }
}
