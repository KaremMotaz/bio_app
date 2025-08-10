import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/exam_entity.dart';

class ExamModel extends ExamEntity {
  ExamModel({
    required super.id,
    required super.title,
    required super.unit,
    required super.lesson,
    required super.endTime,
    required super.passPercentage,
    required super.isPublished,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      id: json['id'],
      title: json['title'],
      unit: json['unit'],
      lesson: json['lesson'],
      endTime: (json['endTime'] as Timestamp).toDate(),
      passPercentage: (json['passPercentage'] as num).toDouble(),
      isPublished: json['isPublished'],
    );
  }
}
