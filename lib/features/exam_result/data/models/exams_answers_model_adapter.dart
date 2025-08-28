import 'package:hive/hive.dart';

import 'exams_answers_model.dart';

class ExamsAnswersModelAdapter
    extends TypeAdapter<ExamsAnswersModel> {
  @override
  final int typeId = 8;

  @override
  ExamsAnswersModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++)
        reader.readByte(): reader.read(),
    };

    return ExamsAnswersModel(
      answers: (fields[0] as Map).cast<String, int>(),
      dateTime: fields[1] as DateTime,
      id: fields[2] as String,
      isResultViewed: fields[3] as bool? ?? false,
    );
  }

  @override
  void write(BinaryWriter writer, ExamsAnswersModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.answers)
      ..writeByte(1)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.isResultViewed);
  }
}
