import 'package:hive/hive.dart';

import 'exam_question_model.dart';

class ExamQuestionsModelAdapter extends TypeAdapter<ExamQuestionsModel> {
  @override
  final int typeId = 6; 

  @override
  ExamQuestionsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return ExamQuestionsModel(
      index: fields[0] as int,
      questionText: fields[1] as String,
      options: (fields[2] as List).cast<String>(),
      correctIndex: fields[3] as int,
      type: ExamOptionsType.values[fields[4] as int],
      marks: fields[5] as int,
      images: (fields[6] as List?)?.cast<String>(),
      title: fields[7] as String?,
      scenario: fields[8] as String?,
      explanation: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ExamQuestionsModel obj) {
    writer
      ..writeByte(10) 
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.questionText)
      ..writeByte(2)
      ..write(obj.options)
      ..writeByte(3)
      ..write(obj.correctIndex)
      ..writeByte(4)
      ..write(obj.type.index)
      ..writeByte(5)
      ..write(obj.marks)
      ..writeByte(6)
      ..write(obj.images)
      ..writeByte(7)
      ..write(obj.title)
      ..writeByte(8)
      ..write(obj.scenario)
      ..writeByte(9)
      ..write(obj.explanation);
  }
}
