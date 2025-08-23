import 'package:hive/hive.dart';
import 'quiz_question_model.dart';

class QuizQuestionModelAdapter extends TypeAdapter<QuizQuestionModel> {
  @override
  final int typeId = 7;

  @override
  QuizQuestionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return QuizQuestionModel(
      index: fields[0] as int,
      questionText: fields[1] as String,
      options: (fields[2] as List).cast<String>(),
      correctIndex: fields[3] as int,
      type: QuizQuestionType.values[fields[4] as int],
      scenario: fields[5] as String?,
      explanation: fields[6] as String?,
      images: (fields[7] as List?)?.cast<String>(),
      marks: fields[8] as int?,
      title: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, QuizQuestionModel obj) {
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
      ..write(obj.scenario)
      ..writeByte(6)
      ..write(obj.explanation)
      ..writeByte(7)
      ..write(obj.images)
      ..writeByte(8)
      ..write(obj.marks)
      ..writeByte(9)
      ..write(obj.title);
  }
}
