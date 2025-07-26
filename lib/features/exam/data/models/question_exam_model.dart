import 'package:bio_app/features/exam/domain/entities/exam_question_entity.dart';

class QuestionExamModel extends ExamQuestionEntity {
  QuestionExamModel({
    required super.id,
    required super.text,
    required super.options,
    required super.correctIndex,
    required super.type,
    required super.marks,
    super.imageUrl,
  });

  factory QuestionExamModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return QuestionExamModel(
      id: map['id'],
      text: map['text'],
      options: List<String>.from(map['options']),
      correctIndex: map['correctIndex'],
      type: map['type'],
      marks: map['marks'],
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'text': text,
    'options': options,
    'correctIndex': correctIndex,
    'type': type,
    'marks': marks,
    'imageUrl': imageUrl,
  };
}
