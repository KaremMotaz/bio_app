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
    required super.isDraft,
  });

  factory ExamModel.fromMap(Map<String, dynamic> map) {
    return ExamModel(
      id: map['id'],
      title: map['title'],
      unit: map['unit'],
      lesson: map['lesson'],
      endTime: (map['endTime'] as Timestamp).toDate(),
      passPercentage: (map['passPercentage'] as num).toDouble(),
      isDraft: map['isDraft'],
    );
  }
}
