import '../../domain/entities/exam_question_entity.dart';

class ExamQuestionModel extends ExamQuestionEntity {
  ExamQuestionModel({
    required super.id,
    required super.questionText,
    required super.options,
    required super.correctIndex,
    required super.type,
    required super.marks,
    super.images,
    super.title,
    super.scenario,
    super.explanation,
  });

  factory ExamQuestionModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return ExamQuestionModel(
      id: map['id'],
      title: map['title'],
      scenario: map['scenario'],
      questionText: map['text'],
      options: List<String>.from(map['options']),
      correctIndex: map['correctIndex'],
      type: map['type'],
      marks: map['marks'],
      images: map['images'],
      explanation: map['explanation'],
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'scenario': scenario,
    'text': questionText,
    'options': options,
    'correctIndex': correctIndex,
    'type': type.name,
    'marks': marks,
    'imageUrl': images,
    'explanation': explanation,
  };
}

enum ExamOptionsType {
  textOptions,
  imageOptions,
  trueFalseOptions,
}
