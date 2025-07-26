import 'package:bio_app/features/exam/data/datasources/mock_exam_data.dart';
import 'package:bio_app/features/exam/data/models/question_exam_model.dart';
import 'package:bio_app/features/exam/domain/entities/exam_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExamModel extends ExamEntity {
  ExamModel({
    required super.id,
    required super.title,
    required super.unit,
    required super.lesson,
    required super.duration,
    required super.startTime,
    required super.endTime,
    required super.passMark,
    required super.questions,
    required super.isDraft,
  });

  factory ExamModel.fromMap(Map<String, dynamic> map) {
    return ExamModel(
      id: map['id'],
      title: map['title'],
      unit: map['unit'],
      lesson: map['lesson'],
      duration: Duration(minutes: map['durationMinutes']),
      startTime: (map['startTime'] as Timestamp).toDate(),
      endTime: (map['endTime'] as Timestamp).toDate(),
      passMark: map['passMark'],
      isDraft: map['isDraft'],
      questions: List<Map<String, dynamic>>.from(
        biologyQuestions,
        // map['questions'],
      ).map((q) => ExamQuestionModel.fromMap(q)).toList(),
    );
  }
  Map<String, dynamic> toMap({required String id}) => {
    'id': id,
    'title': title,
    'unit': unit,
    'lesson': lesson,
    'durationMinutes': duration.inMinutes,
    'startTime': startTime.toIso8601String(),
    'endTime': endTime.toIso8601String(),
    'passMark': passMark,
    'isDraft': isDraft,
    'questions': questions
        .cast<ExamQuestionModel>()
        .map((q) => q.toMap())
        .toList(),
  };
}
