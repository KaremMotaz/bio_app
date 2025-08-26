import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/exam_entity.dart';

class ExamModel extends ExamEntity {
  ExamModel({
    required super.id,
    required super.title,
    required super.unit,
    required super.lesson,
    required super.startTime,
    required super.endTime,
    required super.passPercentage,
    required super.isPublished,
    required super.isResultPublished,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      id: json['id'],
      title: json['title'],
      unit: json['unit'],
      lesson: json['lesson'],
      startTime: json['startTime'] is Timestamp
          ? (json['startTime'] as Timestamp).toDate()
          : (json['startTime'] as DateTime),
      endTime: json['endTime'] is Timestamp
          ? (json['endTime'] as Timestamp).toDate()
          : (json['endTime'] as DateTime),
      passPercentage: (json['passPercentage'] as num).toDouble(),
      isPublished: json['isPublished'],
      isResultPublished: json['isResultPublished'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'unit': unit,
      'lesson': lesson,
      'endTime': Timestamp.fromDate(endTime),
      'startTime': Timestamp.fromDate(startTime),
      'passPercentage': passPercentage,
      'isPublished': isPublished,
      'isResultPublished': isResultPublished,
    };
  }

  Map<String, dynamic> toJsonForHive() {
    return {
      'id': id,
      'title': title,
      'unit': unit,
      'lesson': lesson,
      'endTime': endTime,
      'startTime': startTime,
      'passPercentage': passPercentage,
      'isPublished': isPublished,
      'isResultPublished': isResultPublished,
    };
  }
  factory ExamModel.fromEntity(ExamEntity entity) {
  return ExamModel(
    id: entity.id,
    title: entity.title,
    unit: entity.unit,
    lesson: entity.lesson,
    startTime: entity.startTime,
    endTime: entity.endTime,
    passPercentage: entity.passPercentage,
    isPublished: entity.isPublished,
    isResultPublished: entity.isResultPublished,
  );
}
}
