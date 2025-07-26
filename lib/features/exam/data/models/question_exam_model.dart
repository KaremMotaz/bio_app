import 'package:bio_app/features/exam/domain/entities/exam_question_entity.dart';

class ExamQuestionModel extends ExamQuestionEntity {
  ExamQuestionModel({
    required super.id,
    required super.questionText,
    required super.options,
    required super.correctIndex,
    required super.type,
    required super.marks,
    super.imageUrl,
  });

  factory ExamQuestionModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return ExamQuestionModel(
      id: map['id'],
      questionText: map['text'],
      options: List<String>.from(map['options']),
      correctIndex: map['correctIndex'],
      type: map['type'],
      marks: map['marks'],
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'text': questionText,
    'options': options,
    'correctIndex': correctIndex,
    'type': type,
    'marks': marks,
    'imageUrl': imageUrl,
  };
}

enum ExamQuestionType {
  textChoices,
  imageChoices,
  trueFalse,
}
